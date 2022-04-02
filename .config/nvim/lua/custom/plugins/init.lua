return {
  -- LSP Installer
  {
    "williamboman/nvim-lsp-installer",
  },

  -- 歷史修改紀錄
  {
    "mbbill/undotree",
    opt = true,
    cmd = "UndotreeToggle",
  },

  -- 多光標
  {
    "mg979/vim-visual-multi",
    keys = "<C-n>",
  },

  -- 增刪改引號
  {
    "tpope/vim-surround",
    keys = { "c", "d", "S" },
  },

  -- 格式化程式碼
  {
    "Chiel92/vim-autoformat",
    cmd = 'Autoformat',
  },

  -- 編輯唯讀文件
  {
    "lambdalisue/suda.vim",
    cmd = "SudaWrite"
  },

  -- 函數列表
  {
    "liuchengxu/vista.vim",
    cmd = "Vista",
  },
}
