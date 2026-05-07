" anticuus.vim
" Pitch-black minimalist theme with 256-color terminal fallbacks.

hi clear
if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'anticuus'
set background=dark

function! s:hi(group, guifg, guibg, ctermfg, ctermbg, gui, cterm)
  let l:cmd = 'highlight ' . a:group
  if a:guifg !=# ''
    let l:cmd .= ' guifg=' . a:guifg
  endif
  if a:guibg !=# ''
    let l:cmd .= ' guibg=' . a:guibg
  endif
  if a:ctermfg !=# ''
    let l:cmd .= ' ctermfg=' . a:ctermfg
  endif
  if a:ctermbg !=# ''
    let l:cmd .= ' ctermbg=' . a:ctermbg
  endif
  if a:gui !=# ''
    let l:cmd .= ' gui=' . a:gui
  endif
  if a:cterm !=# ''
    let l:cmd .= ' cterm=' . a:cterm
  endif
  execute l:cmd
endfunction

" === Base ===
call s:hi('Normal',      '#dadada', '#000000', '253', '16',   '', '')
call s:hi('NormalNC',    '#dadada', '#000000', '253', '16',   '', '')
call s:hi('NonText',     '#3a3a3a', 'NONE',    '237', 'NONE', '', '')
call s:hi('EndOfBuffer', '#000000', 'NONE',    '16',  'NONE', '', '')
call s:hi('Whitespace',  '#3a3a3a', '',        '237', '',     '', '')
call s:hi('SpecialKey',  '#3a3a3a', '',        '237', '',     '', '')

" === Syntax: comments dim italic, strings green ===
call s:hi('Comment',        '#5a5a5a', '', '240', '', 'italic', 'italic')
call s:hi('SpecialComment', '#5a5a5a', '', '240', '', 'italic', 'italic')
call s:hi('String',         '#00b300', '', '34',  '', '',       '')
call s:hi('Character',      '#5a5a5a', '', '240', '', 'italic', 'italic')

" === Literals: purple ===
call s:hi('Number',   '#c490d0', '', '176', '', '', '')
call s:hi('Float',    '#c490d0', '', '176', '', '', '')
call s:hi('Boolean',  '#c490d0', '', '176', '', '', '')
call s:hi('Constant', '#c490d0', '', '176', '', '', '')

" === Identifiers / functions: white baseline, functions teal ===
call s:hi('Identifier', '#dadada', '', '253', '', '', '')
call s:hi('Function',   '#88ddcc', '', '116', '', '', '')

" === Statements: yellow keywords, red exception/return ===
call s:hi('Statement',   '#ffcc00', '', '220', '', '', '')
call s:hi('Conditional', '#ffcc00', '', '220', '', '', '')
call s:hi('Repeat',      '#dadada', '', '253', '', '', '')
call s:hi('Keyword',     '#ffcc00', '', '220', '', '', '')
call s:hi('Operator',    '#dadada', '', '253', '', '', '')
call s:hi('Label',       '#ffcc00', '', '220', '', '', '')
call s:hi('Exception',   '#ff6b6b', '', '203', '', '', '')

" === PreProc family: green ===
call s:hi('PreProc',   '#00b300', '', '34', '', '', '')
call s:hi('Include',   '#00b300', '', '34', '', '', '')
call s:hi('Define',    '#00b300', '', '34', '', '', '')
call s:hi('Macro',     '#00b300', '', '34', '', '', '')
call s:hi('PreCondit', '#00b300', '', '34', '', '', '')

" === Types: amber ===
call s:hi('Type',         '#e8a060', '', '215', '', '', '')
call s:hi('StorageClass', '#e8a060', '', '215', '', '', '')
call s:hi('Structure',    '#e8a060', '', '215', '', '', '')
call s:hi('Typedef',      '#e8a060', '', '215', '', '', '')

" === Special: green for special chars, red for tags ===
call s:hi('Special',     '#00b300', '', '34',  '', '', '')
call s:hi('SpecialChar', '#00b300', '', '34',  '', '', '')
call s:hi('Tag',         '#ff6b6b', '', '203', '', '', '')
call s:hi('Delimiter',   '#dadada', '', '253', '', '', '')

" === Errors / Todo ===
call s:hi('Error', '#ff6b6b', '', '203', '', '',     '')
call s:hi('Todo',  '#ffcc00', '', '220', '', 'bold', 'bold')

" === Line numbers / cursor / columns ===
call s:hi('LineNr',       '#dadada', 'NONE',    '253', 'NONE', '',     '')
call s:hi('CursorLineNr', '#dadada', '#282828', '253', '235',  'bold', 'bold')
call s:hi('CursorLine',   '',        '#121212', '',    '233',  'NONE', 'NONE')
call s:hi('CursorColumn', '',        '#121212', '',    '233',  '',     '')
call s:hi('ColorColumn',  '',        '#1a1a1a', '',    '234',  '',     '')
call s:hi('SignColumn',   '#00b300', '#000000', '34',  '16',   '',     '')

" === Splits / status / winbar ===
call s:hi('VertSplit',    '#3a3a3a', 'NONE',    '237', 'NONE', '',     '')
call s:hi('WinSeparator', '#3a3a3a', 'NONE',    '237', 'NONE', '',     '')
call s:hi('StatusLine',   '#dadada', '#000000', '253', '16',   '',     '')
call s:hi('StatusLineNC', '#dadada', '#000000', '253', '16',   '',     '')
call s:hi('WinBar',       '#dadada', '',        '253', '',     'bold', 'bold')
call s:hi('WinBarNC',     '#888888', '',        '245', '',     '',     '')

" === Visual / search ===
call s:hi('Visual',    '',        '#3a3a3a', '',   '237', '', '')
call s:hi('VisualNOS', '',        '#3a3a3a', '',   '237', '', '')
call s:hi('Search',    '#000000', '#ffcc00', '16', '220', '', '')
call s:hi('IncSearch', '#000000', '#88ddcc', '16', '116', '', '')
call s:hi('CurSearch', '#000000', '#c490d0', '16', '176', '', '')

" === Brackets ===
call s:hi('MatchParen', '#c490d0', '', '176', '', 'bold,underline', 'bold,underline')

" === Popup menu (completion / fzf overlay) ===
call s:hi('Pmenu',      '#dadada', '#181818', '253', '234', '', '')
call s:hi('PmenuSel',   '#000000', '#ffcc00', '16',  '220', '', '')
call s:hi('PmenuSbar',  '',        '#181818', '',    '234', '', '')
call s:hi('PmenuThumb', '',        '#3a3a3a', '',    '237', '', '')

" === Folds / titles / directories ===
call s:hi('Folded',     '#888888', '',     '245', '',     'italic', 'italic')
call s:hi('FoldColumn', '#888888', 'NONE', '245', 'NONE', '',       '')
call s:hi('Title',      '#88ddcc', '',     '116', '',     'bold',   'bold')
call s:hi('Directory',  '#88ddcc', '',     '116', '',     '',       '')

" === Diff ===
call s:hi('DiffAdd',    '#a5d6a7', '#0a2010', '151', '22', '','')
call s:hi('DiffChange', '#e8a060', '#201a0a', '215', '58', '','')
call s:hi('DiffDelete', '#ff6b6b', '#200a0a', '203', '52', '','')
call s:hi('DiffText',   '#ffcc00', '#3a2000', '220', '94', 'bold', 'bold')

" === Spell ===
highlight SpellBad   guisp=#ff6b6b gui=undercurl cterm=underline
highlight SpellCap   guisp=#ffcc00 gui=undercurl cterm=underline
highlight SpellRare  guisp=#c490d0 gui=undercurl cterm=underline
highlight SpellLocal guisp=#88ddcc gui=undercurl cterm=underline

" === Markdown (vim's built-in syntax) ===
call s:hi('markdownH1',               '#00b300', '', '34',  '', 'bold',      'bold')
call s:hi('markdownH2',               '#00b300', '', '34',  '', 'bold',      'bold')
call s:hi('markdownH3',               '#00b300', '', '34',  '', 'bold',      'bold')
call s:hi('markdownH4',               '#00b300', '', '34',  '', 'bold',      'bold')
call s:hi('markdownH5',               '#00b300', '', '34',  '', 'bold',      'bold')
call s:hi('markdownH6',               '#00b300', '', '34',  '', 'bold',      'bold')
call s:hi('markdownHeadingDelimiter', '#00b300', '', '34',  '', 'bold',      'bold')
call s:hi('markdownLinkText',         '#88ddcc', '', '116', '', 'underline', 'underline')
call s:hi('markdownUrl',              '#5a5a5a', '', '240', '', 'italic',    'italic')
call s:hi('markdownCode',             '#e8a060', '', '215', '', '',          '')
call s:hi('markdownCodeBlock',        '#e8a060', '', '215', '', '',          '')

" === Diagnostic groups (for plugins like ALE/CoC) ===
call s:hi('DiagnosticError', '#ff6b6b', '', '203', '', '', '')
call s:hi('DiagnosticWarn',  '#ffcc00', '', '220', '', '', '')
call s:hi('DiagnosticInfo',  '#00b300', '', '34',  '', '', '')
call s:hi('DiagnosticHint',  '#dadada', '', '253', '', '', '')
highlight link ALEErrorSign   DiagnosticError
highlight link ALEWarningSign DiagnosticWarn
highlight link ALEInfoSign    DiagnosticInfo

" === vim-highlightedyank ===
call s:hi('HighlightedyankRegion', '#000000', '#ffcc00', '16', '220', '', '')
