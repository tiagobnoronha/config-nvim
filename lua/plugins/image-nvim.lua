return {
  '3rd/image.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'vhyrro/luarocks.nvim',
  },
  config = function()
    require('image').setup {
      backend = 'ueberzug',
      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = false,
        },
        neorg = { enabled = true },
      },
      max_height_window_percentage = math.huge,
      max_width_window_percentage = math.huge,
      max_height_client_percentage = math.huge,
      max_width_client_percentage = math.huge,
      kitty_method = 'normal',
    }
  end,
}
