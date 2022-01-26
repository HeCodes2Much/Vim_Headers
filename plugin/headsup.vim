
"------------------------------------------------------------------------------
" Path          - .config/nvim/plugin/headsup.vim
" GitHub        - https://github.com/The-Repo-Club/
" Author        - The-Repo-Club [wayne6324@gmail.com]
" Start On      - Sun 31 October 2021, 01:17:35 am (GMT)
" Modified On   - Sat 29 January 2022, 06:25:00 pm (GMT) 
"------------------------------------------------------------------------------
" Version=2022.01.28
"------------------------------------------------------------------------------
" Add and update header and its timestamp, including instances of `Version=''`
"  variable (assignment) datestamp in shell scripts, if thisvariable is found.
"  Also cleans up spacing. Does not save; that's up to you.
"
" To use, enter <leader>trchp to place it, and <leader>trchu to update it & the
" aforementioned variable's value, if it's found at the very start of a line.
" To update the version run <leader>trcvp
"------------------------------------------------------------------------------
"

func! <SID>GetDate()
    return strftime("%a %d %B %Y, %I:%M:%S %P (%Z)")
endfunc

func! <SID>GetHeaderLine()
    return "-------------------------------------------------------------------------"
endfunc

func! <SID>GetFile()
    let home = $HOME
    let fname = expand("%")
    return "Path          - " .home."/".fname
endfunc

func! <SID>GetGithub()
    if exists('g:header_github')
        let github = "https://github.com/".g:header_github."/"
    else
        let usergithubname = "https://github.com/Example/"
    endif
    return "GitHub        - ".github
endfunc

func! <SID>GetAuthor()
    if exists('g:header_username')
        let username = g:header_username
    else
        let username = "Example"
    endif
    if exists('g:header_email')
        let email = g:header_email
    else
        let email = "example@gmail.com"
    endif
    let author = username." [".email."]"
    return "Author        - ".author
endfunc

func! <SID>GetStart()
    return "Start On      - " .<SID>GetDate()
endfunc

func! <SID>GetModified()
    return "Modified On   - " .<SID>GetDate()
endfunc

func! <SID>GetVersion()
    let versions = strftime("%Y.%m.%d")
    return "Version=".versions
endfunc

func! TRC_HeadUp(action)
    if (exists("*strftime") == 1)
        exe 'silent normal! mc'
        let b:filetype = &ft

        if (a:action == "place")
            if b:filetype == 'sh' ||
                \ b:filetype == 'fish' ||
                \ b:filetype == 'perl' ||
                \ b:filetype == 'python' ||
                \ b:filetype == "ruby" ||
                \ b:filetype == 'zsh'
                " ---------------------------------------------------------
                if exists('g:header_sh') && b:filetype == 'sh'
                    call setline(1, "\#!/usr/bin/env ".g:header_sh)
                else
                    call setline(1, "\#!/usr/bin/env ".b:filetype)
                endif
                call append(1, "\# -*-coding:utf-8 -*-")
                call append(2, "\# ".<SID>GetHeaderLine())
                call append(3, "\# ".<SID>GetFile())
                call append(4, "\# ".<SID>GetGithub())
                call append(5, "\# ".<SID>GetAuthor())
                call append(6, "\# ".<SID>GetStart())
                call append(7, "\# ".<SID>GetModified())
                call append(8, "\# ".<SID>GetHeaderLine())
                call append(9, <SID>GetVersion())
                call append(10, "\# ".<SID>GetHeaderLine())
                call append(11, "")
                " ---------------------------------------------------------
            elseif b:filetype == "elixir" ||
                \ b:filetype == "make" ||
                \ b:filetype == "tmux" ||
                \ b:filetype == "yaml"
                call setline(1, "\# ".<SID>GetHeaderLine())
                call append(1, "\# ".<SID>GetFile())
                call append(2, "\# ".<SID>GetGithub())
                call append(3, "\# ".<SID>GetAuthor())
                call append(4, "\# ".<SID>GetStart())
                call append(5, "\# ".<SID>GetModified())
                call append(6, "\# ".<SID>GetHeaderLine())
                call append(7, <SID>GetVersion())
                call append(8, "\# ".<SID>GetHeaderLine())
                call append(9, "")
            elseif b:filetype == 'haskell' ||
                \ b:filetype == 'lua'
                call setline(1, "\-- ".<SID>GetHeaderLine())
                call append(1, "\-- ".<SID>GetFile())
                call append(2, "\-- ".<SID>GetGithub())
                call append(3, "\-- ".<SID>GetAuthor())
                call append(4, "\-- ".<SID>GetStart())
                call append(5, "\-- ".<SID>GetModified())
                call append(6, "\-- ".<SID>GetHeaderLine())
                call append(7, <SID>GetVersion())
                call append(8, "\-- ".<SID>GetHeaderLine())
                call append(9, "")
            elseif b:filetype == 'markdown' ||
                \ b:filetype == 'markdown' ||
                \ b:filetype == 'html'
                call setline(1, "\<!-- ".<SID>GetHeaderLine()."")
                call append(1, "\<!-- ".<SID>GetFile()."")
                call append(2, "\<!-- ".<SID>GetGithub()."")
                call append(3, "\<!-- ".<SID>GetAuthor()."")
                call append(4, "\<!-- ".<SID>GetStart()."")
                call append(5, "\<!-- ".<SID>GetModified()."")
                call append(6, "\<!-- ".<SID>GetHeaderLine()."")
                call append(7, <SID>GetVersion()."")
                call append(8, "\<!-- ".<SID>GetHeaderLine()."")
                call append(9, "-->")
                call append(10, "")
            elseif b:filetype == 'vim'
                call setline(1, "\" ".<SID>GetHeaderLine())
                call append(1, "\" ".<SID>GetFile())
                call append(2, "\" ".<SID>GetGithub())
                call append(3, "\" ".<SID>GetAuthor())
                call append(4, "\" ".<SID>GetStart())
                call append(5, "\" ".<SID>GetModified())
                call append(6, "\" ".<SID>GetHeaderLine())
                call append(7, <SID>GetVersion())
                call append(8, "\" ".<SID>GetHeaderLine())
                call append(9, "")
            elseif b:filetype == 'arduino' ||
                \ b:filetype == 'c' ||
                \ b:filetype == 'cpp' ||
                \ b:filetype == 'css' ||
                \ b:filetype == 'cf' ||
                \ b:filetype == 'groovy' ||
                \ b:filetype == 'java' ||
                \ b:filetype == 'kotlin' ||
                \ b:filetype == 'scala' ||
                \ b:filetype == 'javascript' ||
                \ b:filetype == 'javascript.jsx' ||
                \ b:filetype == 'javascriptreact' ||
                \ b:filetype == 'typescript' ||
                \ b:filetype == 'typescriptreact' ||
                \ b:filetype == 'less' ||
                \ b:filetype == 'php' ||
                \ b:filetype == 'go' ||
                \ b:filetype == 'sass' ||
                \ b:filetype == 'rust' ||
                \ b:filetype == 'systemverilog' ||
                \ b:filetype == 'verilog' ||
                \ b:filetype == 'lex' ||
                \ b:filetype == 'yacc'
                call setline(1, "\/** ".<SID>GetHeaderLine())
                call append(1, "\/** ".<SID>GetFile())
                call append(2, "\/** ".<SID>GetGithub())
                call append(3, "\/** ".<SID>GetAuthor())
                call append(4, "\/** ".<SID>GetStart())
                call append(5, "\/** ".<SID>GetModified())
                call append(6, "\/** ".<SID>GetHeaderLine())
                call append(7, <SID>GetVersion())
                call append(8, "\/** ".<SID>GetHeaderLine())
                call append(9, "**/")
                call append(10, "")
            else
                call setline(1, "\#!/usr/bin/env ".b:filetype)
            endif
        elseif (a:action == 'update')
            if (search("^[#/\"]* Modified On\\s*- ", 'ep') > 0)
                exe "silent normal! ld$\"_\"=strftime(\"%a %d %B %Y, %I:%M:%S %P (%Z) \")\<CR>p"
            endif
        endif

        exe "silent normal! `c"
    else
        echo "ERROR: Unable to find strftime() builtin."
    endif
endfunc

noremap <silent> <leader>trchp :call TRC_HeadUp('place')<CR>
noremap <silent> <leader>trchu :call TRC_HeadUp('update')<CR>

if exists('g:header_auto_update') && g:header_auto_update == "true"
    autocmd BufWritePre * silent! :call TRC_HeadUp('update') " Update date when saving buffer
endif
