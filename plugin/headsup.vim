"------------------------------------------------------------------------------
" Path          - .config/nvim/plugin/headsup.vim
" GitHub        - https://github.com/The-Repo-Club/
" Author        - The-Repo-Club [wayne6324@gmail.com]
" Start On      - Sun 31 Oct 00:17:35 BST 2021
" Modified On   - Sun 31 Oct 00:17:35 BST 2021
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

func! TRC_HeadUp(action)
    if (exists("*strftime") == 1)
        exe 'silent normal! mc'

        if (a:action == "place")
            exe "silent normal! i#\<Esc>78a-\<Esc>o"
            exe "silent normal! i# Path         - /usr/bin/\<Esc>\"_\"=expand('%:t')\<CR>po"
            exe "silent normal! i# GitHub       - https://github.com/The-Repo-Club/\<CR>"
            exe "silent normal! i# Author       - The-Repo-Club [wayne6324@gmail.com]\<CR>"
            exe "silent normal! i# Start On     - \<Esc>\"_\"=strftime(\"%a %d %b %Y, %T %Z \")\<CR>po"
            exe "silent normal! i# Modified On  - \<Esc>\"_\"=strftime(\"%a %d %b %T %Z %Y\")\<CR>po"
            exe "silent normal! i#\<Esc>78a-\<Esc>0o"
        elseif (a:action == 'update')
            if (search("^[#/\"]* Modified On\\s*- ", 'ep') > 0)
                exe "silent normal! ld$\"_\"=strftime(\"%a %d %b %T %Z %Y\")\<CR>p"
                if (search('^_VERSION_="', 'ep') > 0)
                    " Shell syntax support. (pre: 2019-11-29)
                    exe "silent normal! di\"\"=strftime(\"%F\")\<CR>P"
                elseif (search("^CurVer='", 'ep') > 0)
                    " Alternative shell syntax support. (post: 2019-11-29)
                    exe "silent normal! di'\"=strftime(\"%F\")\<CR>P"
                elseif (search('^my $CurVer = "', 'ep') > 0)
                    " Perl syntax support.
                    exe "silent normal! di\"\"=strftime(\"%F\")\<CR>P"
                elseif (search("^my $CurVer = '", 'ep') > 0)
                    " Alternative Perl syntax support. (post: 2020-02-02)
                    exe "silent normal! di'\"=strftime('%F')\<CR>P"
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
