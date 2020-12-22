function generic#FindFileUpwards(full_path, filename)
	let dirs = split(a:full_path, '/')
	call remove(dirs, -1)
	" Start building a list of paths in which to look for a file name
        let paths = ['/']
        " /foo/bar/baz would result in the `paths` array containing:
        " [/ /foo /foo/bar /foo/bar/baz]
        for d in dirs
            let paths = add(paths, paths[len(paths) - 1] . d . '/')
        endfor

        " List is backwards search order, so reverse it.
        for d in reverse(paths)
                let file_to_find = d . a:filename
                if filereadable(file_to_find)
                        return file_to_find
                endif
        endfor
endfunction

function generic#RevertHighlightBgGrp(group, color)
	let output = execute('hi ' . a:group)
	let ret = matchstr(output, 'ctermbg=\zs\S*')
	if ret == ""
		exe "hi " . a:group . " ctermbg=" . a:color
	else
		exe "hi clear " . a:group
	endif
endfunction

function generic#Search()
	let grep_term = input("Enter search term: ")
	if !empty(grep_term)
		execute 'silent grep! ' . grep_term | copen
	else
		echo "Empty search term"
	endif
	redraw!
endfunction
