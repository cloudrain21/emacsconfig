1. copy .emacs file into your home directory
2. Run emacs.
   24.4 or later version of emacs is recommanded.
3. Type 'y' for every questions about installing packages.

You can use evil mode, yasnippet, auto complete, relative line number, etc.
Refer to the package list to be installed in .emacs file.

ggtags-find-file is too slow because of the execution of 'global -u'.
You should comment (ggtags-update-tags) function call, in ggtags-read-tag function.
Instead, you should run ggtags in your gtags top directory whenever you modify some files.
