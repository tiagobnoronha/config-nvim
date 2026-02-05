return {
  '3rd/diagram.nvim',
  dependencies = { '3rd/image.nvim' },
  opts = {
    integrations = {
      markdown = true,
    },
    renderer_options = {
      mermaid = {
        theme = 'dark',
        scale = 2,
      },
    },
    events = {
      render_buffer = { 'InsertLeave', 'BufWinEnter', 'TextChanged' },
      clear_buffer = { 'BufLeave' },
    },
  },
  keys = {
    {
      'K',
      function()
        require('diagram').show_diagram_hover()
      end,
      mode = 'n',
      ft = 'markdown',
      desc = 'Render diagram no cursor',
    },
  },
}
