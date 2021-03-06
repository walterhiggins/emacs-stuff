;; http://codewinds.com/blog/2015-04-02-emacs-flycheck-eslint-jsx.html
(defun es6-realtime-linting ()
  "Realtime linting of ES6 and JSX files"
  (add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))
  (require 'flycheck)
  (add-hook 'after-init-hook #'global-flycheck-mode)
; disable jshint since we prefer eslint checking
  (setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
	  '(javascript-jshint)))
  
  ;; use eslint with web-mode for jsx files
  (flycheck-add-mode 'javascript-eslint 'web-mode)
  
  ;; customize flycheck temp file prefix
  (setq-default flycheck-temp-prefix ".flycheck")
  
  ;; disable json-jsonlist checking for json files
  (setq-default flycheck-disabled-checkers
		(append flycheck-disabled-checkers
			'(json-jsonlist)))

  ;; use local eslint from node_modules before global
  ;; http://emacs.stackexchange.com/questions/21205/flycheck-with-file-relative-eslint-executable
  (defun my/use-eslint-from-node-modules ()
    (let* ((root (locate-dominating-file
		  (or (buffer-file-name) default-directory)
		  "node_modules"))
	   (eslint (and root
			(expand-file-name "node_modules/eslint/bin/eslint.js"
					  root))))
      (when (and eslint (file-executable-p eslint))
	(setq-local flycheck-javascript-eslint-executable eslint))))
  (add-hook 'flycheck-mode-hook #'my/use-eslint-from-node-modules)
  )
(es6-realtime-linting)
