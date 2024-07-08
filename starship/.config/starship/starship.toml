# Setups
# format = "$directory$git_branch$character"
format = """
$os\
$directory\

$kubernetes\
$hg_branch\
$docker_context\

$fill\
$git_branch\
$git_status\
$git_commit\
$jobs\
$status\
$container\
$shell\
$time\
$line_break\
$character"""
add_newline = true # Disable the blank line at the start of the prompt


[os]
format = "[](fg:#6791C9 bg:none)[ ](fg:#252525 bg:#6791C9)[](fg:#6791C9 bg:#8994fa)"
disabled = false

[directory]
format = "[  ](fg:#252525 bg:#8994fa)[](fg:#8994fa bg:#252525)[█](fg:#252525 bg:none)[$path]($style)[](fg:#232526 bg:none)"
style = "fg:#E8E3E3 bg:#252525 bold"
truncation_length = 2
truncate_to_repo = true
read_only = "  "
home_symbol = " 󰋜  "

[directory.substitutions]
"Documents" = "  "
"Downloads" = "  "
"Music" = "  "
"Pictures" = "  "

# Prompt symbols
[character]
success_symbol = "[ 🞈 ](#6791C9 bold)"
error_symbol = "[ 🞈 ](#B66467 bold)"

[line_break]
disabled = false

[fill]
symbol = ' '
style = 'bold green'

[git_branch]
format = "[](fg:#252525 bg:none)[$branch]($style)[](fg:#252525 bg:#252525)[](fg:#81C19B bg:#252525)[ ](fg:#252525 bg:#81C19B)[](fg:#81C19B bg:none) "
style = "fg:#E8E3E3 bg:#252525"
truncation_length = 15

[cmd_duration]
min_time = 1
format = "[](fg:#252525 bg:none)[$duration]($style)[](fg:#252525 bg:#252525)[](fg:#C397D8 bg:#252525)[ ](fg:#252525 bg:#C397D8)[](fg:#C397D8 bg:none) "
style = "fg:#E8E3E3 bg:#252525 bold"
show_milliseconds = true
show_notifications = false
min_time_to_notify = 45_000

[git_status]
format = "[](fg:#252525 bg:none)[$all_status$ahead_behind]($style)[](fg:#252525 bg:#252525)[](fg:#6791C9 bg:#252525)[ ](fg:#252525 bg:#6791C9)[](fg:#6791C9 bg:none) "
style = "fg:#E8E3E3 bg:#252525"
conflicted = "🏳"
ahead = "⇡${count}"
behind = "⇣${count}"
diverged = "⇕⇡${ahead_count}⇣${behind_count}"
up_to_date = " 󰄸 "
untracked = "🤷${count}"
stashed = "📦"
modified = "📝${count}"
staged = "++${count}"
renamed = "»${count}"
deleted = " ${count}"

[git_commit]
format = "[\\($hash\\)]($style) [\\($tag\\)]($style)"
style = "green"

[git_state]
rebase = "REBASING"
merge = "MERGING"
revert = "REVERTING"
cherry_pick = "CHERRY-PICKING"
bisect = "BISECTING"
am = "AM"
am_or_rebase = "AM/REBASE"
style = "yellow"
format = '\([$state( $progress_current/$progress_total)]($style)\) '

[time]
disabled = false
time_format = "%R"                                                                                                                                      # Hour:Minute Format
format = "[](fg:#252525 bg:none)[$time]($style)[](fg:#252525 bg:#252525)[](fg:#6791C9 bg:#252525)[󱑂 ](fg:#252525 bg:#6791C9)[](fg:#6791C9 bg:none)"
style = "fg:#E8E3E3 bg:#252525 bold"

[aws]
symbol = "  "

[conda]
symbol = " "

[dart]
symbol = " "

[docker_context]
symbol = " "
format = "via [$symbol$context]($style) "
style = "blue bold"
only_with_files = true
detect_files = ["docker-compose.yml", "docker-compose.yaml", "Dockerfile"]
detect_folders = []
disabled = false

[elixir]
symbol = " "

[elm]
symbol = " "

[golang]
symbol = " "

[hg_branch]
symbol = " "

[java]
symbol = " "

[julia]
symbol = " "

[haskell]
symbol = "λ "

[memory_usage]
symbol = " "

[nim]
symbol = " "

[nix_shell]
symbol = " "

[package]
symbol = " "

[perl]
symbol = " "

[php]
symbol = " "

[python]
symbol = " "
#pyenv_version_name = true
format = 'via [${symbol}python (${version} )(\($virtualenv\) )]($style)'
style = "bold yellow"
pyenv_prefix = "venv "
python_binary = ["./venv/bin/python", "python", "python3", "python2"]
detect_extensions = ["py"]
version_format = "v${raw}"

[ruby]
symbol = " "

[rust]
symbol = "🦀"
style = "bg:#ffb347 fg:#464347"

[scala]
symbol = " "

[shlvl]
symbol = " "

[swift]
symbol = "ﯣ "

[nodejs]
format = "via [ Node.js $version](bold green) "
detect_files = ["package.json", ".node-version"]
detect_folders = ["node_modules"]

# Other languages configurations:
c.disabled = true
cmake.disabled = true
haskell.disabled = true
python.disabled = true
ruby.disabled = true
rust.disabled = true
perl.disabled = true
package.disabled = true
lua.disabled = true
nodejs.disabled = true
java.disabled = true
golang.disabled = true
