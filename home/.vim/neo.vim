set guicursor=

function! StartAIChat()
    execute ':AIChat'
    call feedkeys("\<C-k>")
    call feedkeys("\<C-w>c")
    call feedkeys("i")
endfunction
