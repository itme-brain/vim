" anticuus.vim
" Pitch-black minimalist theme — port of nvim anticuus + custom syntax extensions.
" Requires `set termguicolors`.

hi clear
if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'anticuus'
set background=dark

" === Base ===
highlight Normal       guifg=#dadada guibg=#000000
highlight NormalNC     guifg=#dadada guibg=#000000
highlight NonText      guifg=#3a3a3a guibg=NONE
highlight EndOfBuffer  guifg=#000000 guibg=NONE
highlight Whitespace   guifg=#3a3a3a
highlight SpecialKey   guifg=#3a3a3a

" === Syntax: comments dim italic, strings green ===
highlight Comment        guifg=#5a5a5a gui=italic cterm=italic
highlight SpecialComment guifg=#5a5a5a gui=italic cterm=italic
highlight String         guifg=#00b300
highlight Character      guifg=#5a5a5a gui=italic cterm=italic

" === Literals: purple ===
highlight Number   guifg=#c490d0
highlight Float    guifg=#c490d0
highlight Boolean  guifg=#c490d0
highlight Constant guifg=#c490d0

" === Identifiers / functions: white baseline, functions teal ===
highlight Identifier guifg=#dadada
highlight Function   guifg=#88ddcc

" === Statements: yellow keywords, red exception/return ===
highlight Statement   guifg=#ffcc00
highlight Conditional guifg=#ffcc00
highlight Repeat      guifg=#dadada
highlight Keyword     guifg=#ffcc00
highlight Operator    guifg=#dadada
highlight Label       guifg=#ffcc00
highlight Exception   guifg=#ff6b6b

" === PreProc family: green ===
highlight PreProc   guifg=#00b300
highlight Include   guifg=#00b300
highlight Define    guifg=#00b300
highlight Macro     guifg=#00b300
highlight PreCondit guifg=#00b300

" === Types: amber ===
highlight Type         guifg=#e8a060
highlight StorageClass guifg=#e8a060
highlight Structure    guifg=#e8a060
highlight Typedef      guifg=#e8a060

" === Special: green for special chars, red for tags ===
highlight Special     guifg=#00b300
highlight SpecialChar guifg=#00b300
highlight Tag         guifg=#ff6b6b
highlight Delimiter   guifg=#dadada

" === Errors / Todo ===
highlight Error guifg=#ff6b6b
highlight Todo  guifg=#ffcc00 gui=bold cterm=bold

" === Line numbers / cursor / columns ===
highlight LineNr        guifg=#dadada guibg=NONE
highlight CursorLineNr  guifg=#dadada guibg=#282828 gui=bold cterm=bold
highlight CursorLine    guibg=#121212
highlight CursorColumn  guibg=#121212
highlight ColorColumn   guibg=#1a1a1a
highlight SignColumn    guifg=#00b300 guibg=#000000

" === Splits / status / winbar ===
highlight VertSplit    guifg=#3a3a3a guibg=NONE
highlight WinSeparator guifg=#3a3a3a guibg=NONE
highlight StatusLine   guifg=#dadada guibg=#000000
highlight StatusLineNC guifg=#dadada guibg=#000000
highlight WinBar       guifg=#dadada gui=bold cterm=bold
highlight WinBarNC     guifg=#888888

" === Visual / search ===
highlight Visual    guibg=#3a3a3a
highlight VisualNOS guibg=#3a3a3a
highlight Search    guifg=#000000 guibg=#ffcc00
highlight IncSearch guifg=#000000 guibg=#88ddcc
highlight CurSearch guifg=#000000 guibg=#c490d0

" === Brackets ===
highlight MatchParen guifg=#c490d0 gui=bold,underline cterm=bold,underline

" === Popup menu (completion / fzf overlay) ===
highlight Pmenu      guifg=#dadada guibg=#181818
highlight PmenuSel   guifg=#000000 guibg=#ffcc00
highlight PmenuSbar  guibg=#181818
highlight PmenuThumb guibg=#3a3a3a

" === Folds / titles / directories ===
highlight Folded     guifg=#888888 gui=italic cterm=italic
highlight FoldColumn guifg=#888888 guibg=NONE
highlight Title      guifg=#88ddcc gui=bold cterm=bold
highlight Directory  guifg=#88ddcc

" === Diff ===
highlight DiffAdd    guifg=#a5d6a7 guibg=#0a2010
highlight DiffChange guifg=#e8a060 guibg=#201a0a
highlight DiffDelete guifg=#ff6b6b guibg=#200a0a
highlight DiffText   guifg=#ffcc00 guibg=#3a2000 gui=bold cterm=bold

" === Spell ===
highlight SpellBad   guisp=#ff6b6b gui=undercurl cterm=underline
highlight SpellCap   guisp=#ffcc00 gui=undercurl cterm=underline
highlight SpellRare  guisp=#c490d0 gui=undercurl cterm=underline
highlight SpellLocal guisp=#88ddcc gui=undercurl cterm=undercurl

" === Markdown (vim's built-in syntax) ===
highlight markdownH1               guifg=#00b300 gui=bold cterm=bold
highlight markdownH2               guifg=#00b300 gui=bold cterm=bold
highlight markdownH3               guifg=#00b300 gui=bold cterm=bold
highlight markdownH4               guifg=#00b300 gui=bold cterm=bold
highlight markdownH5               guifg=#00b300 gui=bold cterm=bold
highlight markdownH6               guifg=#00b300 gui=bold cterm=bold
highlight markdownHeadingDelimiter guifg=#00b300 gui=bold cterm=bold
highlight markdownLinkText         guifg=#88ddcc gui=underline cterm=underline
highlight markdownUrl              guifg=#5a5a5a gui=italic cterm=italic
highlight markdownCode             guifg=#e8a060
highlight markdownCodeBlock        guifg=#e8a060

" === Diagnostic groups (for plugins like ALE/CoC) ===
highlight DiagnosticError guifg=#ff6b6b
highlight DiagnosticWarn  guifg=#ffcc00
highlight DiagnosticInfo  guifg=#00b300
highlight DiagnosticHint  guifg=#dadada
highlight link ALEErrorSign   DiagnosticError
highlight link ALEWarningSign DiagnosticWarn
highlight link ALEInfoSign    DiagnosticInfo

" === vim-highlightedyank ===
highlight HighlightedyankRegion guifg=#000000 guibg=#ffcc00
