function generic#find_file_upwards(full_path, filename)
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
