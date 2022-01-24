"------------------------------------------------------------------------------
" Path         - .config/nvim/plugin/versionup.vim
" GitHub       - https://github.com/The-Repo-Club/
" Author       - The-Repo-Club [wayne6324@gmail.com]
" Start On     - Mon 1 Nov 20:23:12 GMT 2021
" Modified On  - Mon 1 Nov 20:23:12 GMT 2021
"------------------------------------------------------------------------------
"
" Add and update header and its timestamp, including instances of `CurVer=''`
" or `_VERSION_=""` variable (assignment) datestamp in shell scripts, if this
" variable is found. Also cleans up spacing. Does not save; that's up to you.
"
" For now, you'll have to change header information (E-Mail and GitHub entries)
" to match your own; it'll hopefully be more user-friendly in the future.
"
" To use, enter <leader>vp to place it, and <leader>vu to update it & the
" aforementioned variable's value, if it's found at the very start of a line.
"------------------------------------------------------------------------------

Version=2022.01.24

func! TRC_VersionUp(action)
	if (exists("*strftime") == 1)
		exe 'silent normal! mc'

		if (a:action == "place")
			exe "silent normal! iVersion=\<Esc>\"_\"=strftime(\"%Y.%m.%d\")\<CR>po"
		elseif (a:action == 'update')
			if (search("^Version\\s*=", 'ep') > 0)
				exe "silent normal! ld$\"_\"=strftime(\"%Y.%m.%d\")\<CR>p"
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
            elseif (search("^version\\s*=", 'ep') > 0)
				exe "silent normal! ld$\"_\"=strftime(\"%Y.%m.%d\")\<CR>p"
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

noremap <silent> <leader>trcvp :call TRC_VersionUp('place')<CR>
noremap <silent> <leader>trcvu :call TRC_VersionUp('update')<CR>
