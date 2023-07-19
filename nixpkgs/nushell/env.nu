def git_parse_branch [] {
  git rev-parse --abbrev-ref HEAD out+err> /dev/null

  let branch_status = if $env.LAST_EXIT_CODE == 0 {
    $"(ansi blue)\( (git rev-parse --abbrev-ref HEAD)\)"    
  } else {
      ""
  }

  $branch_status
}

export def create_left_prompt [] {
  let path_segment = $"(ansi blue)[(ansi green)($env.USER) (ansi yellow)➜  (ansi green)(date now | date format '%r')(ansi blue)]"

  let exit_code_segment = if ($env.LAST_EXIT_CODE == 0) {
    $" (ansi blue)$ "
  } else {
    $" (ansi red)$ "
  }

  let working_dir_segment = $"(ansi yellow)($env.PWD | str replace $env.HOME '~') "

  let git_branch = $"(ansi blue)(git_parse_branch)(ansi reset)"

  [$path_segment, $exit_code_segment, $working_dir_segment $git_branch] | str join
}

let-env PROMPT_COMMAND = { print (create_left_prompt) }
let-env PROMPT_COMMAND_RIGHT = ""

# The prompt indicators are environmental variables that represent
# the state of the prompt
let-env PROMPT_INDICATOR =  "ᗆ "
let-env PROMPT_INDICATOR_VI_INSERT = "〉"
let-env PROMPT_INDICATOR_VI_NORMAL = "ᗆ "
let-env PROMPT_MULTILINE_INDICATOR = "::: "

