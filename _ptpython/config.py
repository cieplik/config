from ptpython.layout import CompletionVisualisation

__all__ = (
  'configure',
)


def configure(repl):
  repl.show_signature = True
  repl.show_docstring = True
  repl.completion_visualisation = CompletionVisualisation.POP_UP
  repl.highlight_matching_parenthesis = True
  repl.complete_while_typing = True
  repl.vi_mode = True
  repl.confirm_exit = False
  repl.use_code_colorscheme('rrt')
