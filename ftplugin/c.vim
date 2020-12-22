" Keep everything buffer-local in this file since it runs every time new or existing file,
" which is not already open in a loaded buffer, edited

"━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━Configuration━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

" Plugin: coc.nvim
" Highlight the symbol and its references when holding the cursor
autocmd CursorHold <buffer> silent call CocActionAsync('highlight')

"━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

"━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━Shortcuts━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

onoremap <buffer> q i"
inoremap <buffer> kj <esc>:w<CR>

" Plugin: coc.nvim
" Use <c-space> to trigger completion
inoremap <buffer><silent><expr> <c-@> coc#refresh()
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <buffer><silent> [g <Plug>(coc-diagnostic-prev)
nmap <buffer><silent> ]g <Plug>(coc-diagnostic-next)
" Browse & Refactor code
nmap <buffer><silent> gf <Plug>(coc-definition)
nmap <buffer><silent> gd <Plug>(coc-declaration)
nmap <buffer><silent> gi <Plug>(coc-implementation)
nmap <buffer><silent> gr <Plug>(coc-references)
" Formatting selected code.
xmap <buffer><LocalLeader>ft  <Plug>(coc-format-selected)
nmap <buffer><LocalLeader>ft  <Plug>(coc-format-selected)
nmap <buffer><LocalLeader>r <Plug>(coc-rename)
nmap <buffer><LocalLeader>a  <Plug>(coc-codeaction)
nmap <buffer><LocalLeader>fx  <Plug>(coc-fix-current)
" Select range
nmap <buffer><silent> <C-s> <Plug>(coc-range-select)
xmap <buffer><silent> <C-s> <Plug>(coc-range-select)
" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)
" Use K to show documentation in preview window.
nnoremap <buffer><silent> K :call ft#c#show_documentation()<CR>
" Cycle float window with Ctrl-f/Ctrl-b
nnoremap <buffer><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <buffer><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <buffer><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <buffer><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                            \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
nnoremap <C-j> :CocCommand document.jumpToNextSymbol<CR>
nnoremap <C-k> :CocCommand document.jumpToPrevSymbol<CR>

"━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
