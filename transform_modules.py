import re
import sys
import os

files_info = [
    ("nixos/configuration.nix", "configuration", "Main NixOS system configuration"),
    ("nixos/packages.nix", "packages", "Custom packages and overrides"),
    ("nixos/services.nix", "services", "System-wide services configuration"),
    ("nixos/modules/keyd.nix", "keyd", "Keyboard daemon (keyd) configuration"),
    ("nixos/modules/obs.nix", "obs", "OBS Studio with custom plugins"),
    ("nixos/modules/virt-ydot.nix", "virt-ydot", "Virtual ydotool service"),
    ("variety/caelestia-base.nix", "caelestia-base", "Base configuration for the Caelestia flavor"),
    ("variety/gnome.nix", "gnome", "GNOME desktop environment configuration"),
    ("variety/illogical-base.nix", "illogical-base", "Base configuration for the Illogical flavor"),
    ("variety/plasma.nix", "plasma", "KDE Plasma desktop environment configuration"),
    ("home-manager/modules/_caelestia.nix", "caelestia", "Caelestia flavor home-manager module"),
    ("home-manager/modules/_fish.nix", "fish", "Fish shell configuration"),
    ("home-manager/modules/git.nix", "git", "Git configuration"),
    ("home-manager/modules/illogical.nix", "illogical", "Illogical flavor home-manager module"),
    ("home-manager/modules/nixvim.nix", "nixvim", "NixVim configuration"),
    ("home-manager/modules/spicetify.nix", "spicetify", "Spicetify-nix configuration"),
    ("home-manager/modules/starship.nix", "starship", "Starship prompt configuration"),
    ("home-manager/modules/_theming.nix", "theming", "Theming configuration"),
    ("home-manager/modules/vscode.nix", "vscode", "VS Code configuration"),
    ("home-manager/modules/xdg.nix", "xdg", "XDG user directories and MIME apps"),
    ("home-manager/modules/packages/browsers.nix", "pkg-browsers", "Web browsers"),
    ("home-manager/modules/packages/cli-utilities.nix", "pkg-cli-utilities", "CLI utilities"),
    ("home-manager/modules/packages/communication.nix", "pkg-communication", "Communication apps"),
    ("home-manager/modules/packages/creative.nix", "pkg-creative", "Creative tools"),
    ("home-manager/modules/packages/_faith-tools.nix", "pkg-faith-tools", "Tools for Faith"),
    ("home-manager/modules/packages/file-management.nix", "pkg-file-management", "File management tools"),
    ("home-manager/modules/packages/fonts.nix", "pkg-fonts", "Fonts"),
    ("home-manager/modules/packages/gaming.nix", "pkg-gaming", "Gaming applications"),
    ("home-manager/modules/packages/media.nix", "pkg-media", "Media players and tools"),
    ("home-manager/modules/packages/misc.nix", "pkg-misc", "Miscellaneous packages"),
    ("home-manager/modules/packages/_niver-tools.nix", "pkg-niver-tools", "Tools for Niver"),
    ("home-manager/users/faith.nix", "user-faith", "Faith's home-manager configuration"),
    ("home-manager/users/niver.nix", "user-niver", "Niver's home-manager configuration"),
    ("hosts/kale-hardware.nix", "host-kale-hw", "Hardware configuration for host Kale"),
    ("hosts/kale.nix", "host-kale", "Configuration for host Kale"),
    ("hosts/nomi.nix", "host-nomi", "Configuration for host Nomi"),
]

def find_matching_brace(s, start):
    count = 0
    for i in range(start, len(s)):
        if s[i] == '{':
            count += 1
        elif s[i] == '}':
            count -= 1
            if count == 0:
                return i
    return -1

def transform_file(file_path, module_name, description):
    print(f"Transforming {file_path}...")
    with open(file_path, 'r') as f:
        content = f.read()

    # Find the module assignment
    pattern = rf'flake\.(nixosModules|homeModules)\.{module_name}\s*='
    match = re.search(pattern, content)
    if not match:
        print(f"Failed to find module assignment in {file_path}")
        return

    prefix_end = match.end()
    # Now find the start of the module expression (it should be a function or set)
    # Actually, let's just find the closing brace that matches the first opening brace after the '='
    # Wait, the module could be just a function: { pkgs, ... }: { ... }
    # So we need to find the start of the function, then find where its body ends.
    # If it's a function: { ... }: { ... }
    # The whole thing is the module.

    # Find where the module ends. Usually it's followed by a semicolon OR a closing brace of the outer set.
    # But let's look for the semicolon first, if it exists.
    # In some cases there's no semicolon.
    
    # Let's find the closing brace of the module function body.
    # A module is usually { ... }: { ... } or { ... }: something.
    
    # Find the first '{' after prefix_end
    start_brace = content.find('{', prefix_end)
    if start_brace == -1:
        print(f"Failed to find start brace in {file_path}")
        return
    
    # This '{' is the start of the function arguments or the module body.
    # We want to find the end of the whole expression assigned to flake...
    # The assignment ends either at a semicolon ';' or at the '}' of the outer set.
    
    # Let's search for ';' after prefix_end.
    semi_pos = content.find(';', prefix_end)
    outer_end_brace = content.rfind('}', prefix_end) # This might be too late.
    
    # Actually, let's just take everything from prefix_end to the semicolon, 
    # OR if no semicolon, to the last closing brace minus one.
    
    if semi_pos != -1:
        original_module = content[prefix_end:semi_pos].strip()
        end_pos = semi_pos
    else:
        # No semicolon, it must be the last attribute.
        # It ends before the last '}' in the file.
        last_brace = content.rfind('}')
        original_module = content[prefix_end:last_brace].strip()
        end_pos = last_brace

    new_module_expr = f" {{\n    description = \"{description}\";\n    imports = [\n      ({original_module})\n    ];\n  }}"
    
    new_content = content[:prefix_end] + new_module_expr + content[end_pos:]

    # Also update the outer function arguments to include inputs if needed
    outer_args_pattern = re.compile(r'^\{\s*([^}]*)\s*\}\s*:', re.MULTILINE)
    def outer_args_replacement(match):
        args = match.group(1).strip()
        if 'inputs' not in args:
            if '...' in args:
                args = args.replace('...', 'inputs, ...')
            else:
                if args:
                    args = args + ', inputs'
                else:
                    args = 'inputs'
        return f"{{ {args} }}:"
    
    new_content = outer_args_pattern.sub(outer_args_replacement, new_content, count=1)

    with open(file_path, 'w') as f:
        f.write(new_content)

for file_path, module_name, description in files_info:
    transform_file(file_path, module_name, description)
