## Whether to display a banner upon starting IPython.
c.TerminalIPythonApp.display_banner = False

## If a command or file is given via the command-line, e.g. 'ipython foo.py',
#  start an interactive shell after executing the file or command.
c.TerminalIPythonApp.force_interact = True

## Make IPython automatically call any callable object even if you didn't type
#  explicit parentheses. For example, 'str 43' becomes 'str(43)' automatically.
#  The value can be '0' to disable the feature, '1' for 'smart' autocall, where
#  it is not applied if there are no more arguments on the line, and '2' for
#  'full' autocall, where all callable objects are automatically called (even if
#  no arguments are present).
c.InteractiveShell.autocall = 1

## Total length of command history
c.InteractiveShell.history_length = 100000

## The number of saved history entries to be loaded into the history buffer at
#  startup.
c.InteractiveShell.history_load_length = 10000

## Automatically call the pdb debugger after every exception.
c.InteractiveShell.pdb = True

c.InteractiveShell.wildcards_case_sensitive = False

## Autoformatter to reformat Terminal code. Can be `'black'` or `None`
c.TerminalInteractiveShell.autoformatter = "black"

## Number of line at the bottom of the screen to reserve for the tab completion
#  menu, search history, ...etc, the height of these menus will at most this
#  value. Increase it is you prefer long and skinny menus, decrease for short and
#  wide.
c.TerminalInteractiveShell.space_for_menu = 10

## Use 24bit colors instead of 256 colors in prompt highlighting. If your
#  terminal supports true color, the following command should print 'TRUECOLOR'
#  in orange: printf "\x1b[38;2;255;100;0mTRUECOLOR\x1b[0m\n"
c.TerminalInteractiveShell.true_color = True

## If True, any %store-d variables will be automatically restored when IPython
#  starts.
c.StoreMagics.autorestore = True

c.InteractiveShell.autoindent = True
c.PlainTextFormatter.pprint = True
c.TerminalInteractiveShell.confirm_exit = False
