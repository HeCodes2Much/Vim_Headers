"------------------------------------------------------------------------------
" Path          - .config/nvim/plugin/headsup.vim
" GitHub        - https://github.com/The-Repo-Club/
" Author        - The-Repo-Club [wayne6324@gmail.com]
" Start On      - Sun 31 October 2021, 01:17:35 am (GMT)
" Modified On   - Mon 24 January 2022, 05:12:44 pm (GMT)
"------------------------------------------------------------------------------

" Add and update header and its timestamp, including instances of `CurVer=''`
" or `_VERSION_=""` variable (assignment) datestamp in shell scripts, if this
" variable is found. Also cleans up spacing. Does not save; that's up to you.
"
" For now, you'll have to change header information (E-Mail and GitHub entries)
" to match your own; it'll hopefully be more user-friendly in the future.
"
" To use, enter <leader>hp to place it, and <leader>hu to update it & the
" aforementioned variable's value, if it's found at the very start of a line.
"------------------------------------------------------------------------------

" Version=2022.01.24
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
    let github = "https://github.com/The-Repo-Club/"
    return "GitHub        - ".github
endfunc

func! <SID>GetAuthor()
    let username = "The-Repo-Club"
    let email = "wayne6324@gmail.com"
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

        if (a:action == "place")
            if &filetype == 'sh'
                call setline(1, "\#!/usr/bin/env bash")
                call append(1, "\# -*-coding:utf-8 -*-")
                call append(2, "\# ".<SID>GetHeaderLine())
                call append(3, "\# ".<SID>GetFile())
                call append(4, "\# ".<SID>GetGithub())
                call append(5, "\# ".<SID>GetAuthor())
                call append(6, "\# ".<SID>GetStart())
                call append(7, "\# ".<SID>GetModified())
                call append(8, "\# ".<SID>GetHeaderLine())
                call append(9, "\# ".<SID>GetVersion())
                call append(10, "\# ".<SID>GetHeaderLine())
                call append(11, "")
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

func! TRC_VersionUp(action)
	if (exists("*strftime") == 1)
        if (a:action == 'update')
            if &filetype == 'sh'
                if (search("^# Version\\s*=", 'ep') > 0)
                    exe "silent normal! ld$\"_\"=strftime(\"%Y.%m.%d\")\<CR>p"
                endif
            endif
        endif

        exe "silent normal! `c"
    else
        echo "ERROR: Unable to find strftime() builtin."
    endif
endfunc

noremap <silent> <leader>trchp :call TRC_HeadUp('place')<CR>
noremap <silent> <leader>trchu :call TRC_HeadUp('update')<CR>
noremap <silent> <leader>trcvp :call TRC_VersionUp('place')<CR>
