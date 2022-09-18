require 'colorizer'.setup {
  '*';
  css = { rgb_fn = true; }; -- Enable parsing rgb(...) functions in css.
  html = { names = false; } -- Disable parsing "names" like Blue or Gray
}
