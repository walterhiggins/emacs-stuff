;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Walter Higgins _emacs file
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(menu-bar-mode nil)
(tool-bar-mode nil)
; dont show startup message
(setq inhibit-startup-message t)

; highlight marked  area
(setq transient-mark-mode 't)

; Always end a file with a newline
(setq require-final-newline t)

;; ; Enable wheelmouse support by default
;; (cond (window-system
;; 		 ;(setq w32-use-w32-font-dialog nil)
;; 		 ;(setq w32-fixed-font-alist
;; ;				 (append w32-fixed-font-alist 
;; ;							'(("Walters"
;; ;								("tiny" "-outline-ProggyTinyTT-normal-r-normal-normal-16-120-96-96-c-*-iso10646-1")
;; ;								("large" "-outline-Bitstream Vera Sans Mono-normal-r-normal-normal-12-90-96-96-c-*-iso10646-1"))))
;; ;				 )
;;        (mwheel-install)
;;        ))

; frame title : set to buffer name
;(setq frame-title-format "Emacs - %f ")  
(setq frame-title-format "%f")
(setq icon-title-format  "%b")

; display line number in mode line
(setq line-number-mode 1)

; display column number in mode line
(setq column-number-mode 1)

; highlight words during query replacement
(setq query-replace-highlight t)
window-system
; highlight matches during search
(setq search-highlight t)

; ensure all contents of minibuffer visible
(setq resize-minibuffer-mode t)

; Visible bell - no beeping!
(setq visible-bell t)

; So we can see pound signs ok 
;
; wph 20070626 obsolete in 22.1
;
;(standard-display-european t) 
;
; Walter Higgins: 20040519
; Useful function
;
(defun wph-insert-filename()
  "Insert the filename of the current buffer at point"
  (interactive)
  (insert buffer-file-name)
  )
(global-set-key "\C-c\C-f" 'wph-insert-filename)

; Useful key strokes
(global-set-key "\C-c\C-g" 'goto-line)

;
(setq special-display-buffer-names '("*Shell Command Output*"))

;
; margin-mode is my own 1st minor mode 
;
;(load "margin")

; set up some font-lock stuff 
(load-library "font-lock")
(global-font-lock-mode 1)

; if I want to permanently change the font used by Win2K...
; sometimes the ISO page number will be incorrect ,
; use iso8859
;(if (eq window-system 'w32)
;    (defun insert-x-style-font()
;      "Insert a string in X format which describes font"
;      (interactive)
;      (insert (prin1-to-string (w32-select-font)))))

; standard hooks
(add-hook 'text-mode-hook 'auto-fill-mode)
(add-hook 'fundamental-mode-hook 'auto-fill-mode)

;------------------------------------------------------------------------------
;
; java stuff starts here...
;
(setq java-mode-hook
      '(lambda ()
; align '{' underneath conditional
         (c-set-offset 'substatement-open 0)
; automatic newline when {, }, or ; is typed
         (c-toggle-auto-hungry-state 1)
         (setq indent-tabs-mode nil)
         (message (concat "java-mode-hook called for: " (buffer-name)))
         ;;(add-hook 'post-command-hook 'jsp-movement-hook)
         ))
;
; bp or bean-property
;
(defun bp (propType propName)
  "add a new bean property"
  (interactive "sPlease enter type: \nsPlease enter name: ")
  (insert (concat "private " propType " " propName " = null; \n"))
  (insert (concat "public void set" 
                  (upcase-initials propName) 
                  "(" 
                  propType 
                  " value){\nthis." 
                  propName 
                  "= value;\n}\n"))
  (insert (concat "public " 
                  propType 
                  " get" 
                  (upcase-initials propName) 
                  "(){\n return " 
                  propName 
                  ";\n}\n"))
  )
;
; ctrl t - ctrl c will wrap a try-catch block around the selected text
; and move the point to the catch block ready for inserting 
; error-handling code 
;
(define-skeleton try-catch-skel
  "enclose selected text in a try-catch block"
  nil  
  > "try{" \n  
  > _  
  \n "}catch(Exception exception){" >
  \n "// something went wrong ..."
  \n @ \n  "}">)
;
; need to load cc-mode before adding key-bindings to java-mode-map
;
(load-library "cc-mode")
(define-key java-mode-map "\C-t\C-c" 'try-catch-skel)



;
; Javascript skeletons
;
(define-skeleton docid-skel
  ""
  nil
  "document.getElementById(\"" _ "\")")
(define-key java-mode-map "\C-c\C-jj" 'docid-skel)

(define-skeleton document-createElement-skel
  "shortcut for document.createElement()"
  nil
  "document.createElement(\"" _ "\")")
(define-key java-mode-map "\C-c\C-jc" 'document-createElement-skel)



; 
; for webservices
;
(setq auto-mode-alist
      (cons '("\\.jws\\'" . java-mode) auto-mode-alist))
;
; for decompiling java classes
;
(setq auto-mode-alist
      (cons '("\\.class\\'" . java-mode) auto-mode-alist))
(add-to-list 'file-coding-system-alist 
             '("\\.class\\'" dos))

;------------------------------------------------------------------------------
;
; custom variables
;
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(abbrev-mode t)
 '(ange-ftp-netrc-default-user "walter")
 '(archive-tmpdir "c:/scratch/")
 '(archive-zip-extract (quote ("perl" "c:/home/bin/unzip.pl")))
 '(archive-zip-use-pkzip t)
 '(c-basic-offset 4)
 '(column-number-mode t)
 '(cperl-indent-level 4)
 '(cperl-invalid-face (quote default) t)
 '(font-lock-maximum-decoration (quote ((t . t) (t . t))))
;; '(ftp-program "c:\\cygwin\\bin\\ftp.exe")
 '(ftp-program-options nil)
 '(global-font-lock-mode t nil (font-lock))
 '(mail-user-agent (quote sendmail-user-agent))
 '(org-agenda-files (quote ("c:/home/scratch/work.org")))
 '(org-log-done (quote time))
;; '(shell-file-name "C:\\cygwin\\bin\\sh.exe")
 '(tab-width 3)
 '(tool-bar-mode nil)
 '(user-full-name "Walter Higgins")
 )

; abbreviations
;(read-abbrev-file "~/_abbrev_defs")
; if prompt to save on close gets too annoying, comment this out
;(setq save-abbrevs t)

; Frame setup and colour setup
;
(setq w32-enable-italics t)    
;
; maximise the window
; (windows only)
;(w32-send-sys-command 61488)

(defun slideshow-mode()
  ""
  (interactive "")
  (set-face-foreground 'modeline "#303030")
  (set-face-background 'modeline "#303030")
  (custom-set-faces
   '(cursor    ((t (:background "#304040" :foreground "green"))))
	)
)
(setq auto-mode-alist
      (cons '("\\.slides\\'" . outline-mode) auto-mode-alist))

;------------------------------------------------------------------------------
; Functions that change colors
;

(defun theme-writeroom()
  (interactive "")
  (setq default-frame-alist      
        '((foreground-color . "#36d003")    
          (background-color . "#141414")
          ))
  (set-cursor-color "yellow")
  (set-mouse-color "yellow")
  (set-face-foreground 'modeline "white")
  (set-face-background 'modeline "#2a9400")
  (set-face-background 'region "#2a9400")
  (set-face-background 'highlight "#2a9400")
  (custom-set-faces
   '(default ((t (:foreground "#36d003" :background "#141414"))))
   '(cursor    ((t (:background "#36d003" :foreground "#141414"))))
   '(highlight ((t (:background "#2a9400" :foreground "#38d000"))))
   '(region    ((t (:background "#2a9400"     :foreground "#40d800"))))
   '(modeline ((t (:foreground "white" :background "#2a9400" ))))
   '(font-lock-builtin-face ((t (:foreground "#48d800"))))
;   '(margin-face ((t (:background "lightgray"))))
   '(font-lock-comment-face ((t (:foreground "forest green"))))
   '(font-lock-constant-face ((t (:foreground "medium sea green" ))))
   '(font-lock-function-name-face ((t (:bold t :foreground "lime green" ))))
   '(font-lock-keyword-face ((t (:foreground "#3fd400"))))
   '(font-lock-string-face ((t (:foreground "#50df00"))))
   '(font-lock-type-face ((t (:foreground "#44d800"))))
   '(font-lock-variable-name-face ((t (:foreground "#48d800"))))
   '(cperl-array-face ((t (:foreground "lime green"))))
   '(cperl-nonoverridable-face ((t (:foreground "lime green"))))
   '(cperl-hash-face ((t (:foreground "lime green"))))
   )
  )
  
; katester was preferred scheme for 2+ years but doesn't look 
; good with bitstream vera fonts
; 
(defun theme-katester()
  "Sets the color scheme to katester"
  (interactive "")
  (setq default-frame-alist      
        '((foreground-color . "black")    
          (background-color . "ivory")
          ))
  (set-cursor-color "slateblue")
  (set-mouse-color "slateblue")
  (set-face-foreground 'modeline "black")
  (set-face-background 'modeline "mistyRose")
  (set-face-background 'region "lavender")
  (set-face-background 'highlight "mistyRose")
  (custom-set-faces
   '(default ((t (:foreground "#000000" :background "ivory"))))
   '(cursor    ((t (:background "slateblue" :foreground "black"))))
   '(highlight ((t (:background "mistyRose" :foreground "black"))))
   '(region    ((t (:background "lavender"     :foreground "black"))))
   '(modeline ((t (:foreground "navy" 
                               :background "mistyRose" 
                               :box (:line-width 1 
                                                 :color "grey75" 
                                                 :style released-button)))))
   '(font-lock-builtin-face ((t (:foreground "blue"))))
;   '(margin-face ((t (:background "lightgray"))))
   '(font-lock-comment-face ((t (:foreground "navy"))))
   '(font-lock-constant-face ((t (:foreground "darkred"))))
   '(font-lock-function-name-face ((t (:underline t :bold t :foreground "blue" ))))
   '(font-lock-keyword-face ((t (:foreground "blue"))))
   '(font-lock-string-face ((t (:foreground "thistle4"))))
   '(font-lock-type-face ((t (:foreground "blue"))))
   '(font-lock-variable-name-face ((t (:foreground "black"))))
   )
  )
;
; yet another color theme - 
; 
(defun theme-matrix()
  "Sets the color scheme to matrix"
  (interactive "")
  (setq default-frame-alist      
        '((foreground-color . "green")    
          (background-color . "#000000")
          ))
  (set-cursor-color "#7eff00")
  (set-mouse-color "#7eff00")
  (set-face-foreground 'modeline "#101010")
  (set-face-background 'modeline "seagreen")   
  (set-face-background 'region "#7eff00")
  (set-face-background 'highlight "#7eff00")
  (custom-set-faces
   '(default   ((t (:background "black" :foreground "green" ))))
   '(cursor    ((t (:background "yellow" :foreground "green1"))))
   '(highlight ((t (:background "yellow" :foreground "black"))))
   '(region    ((t (:background "yellow"     :foreground "black")))) 
   '(modeline ((t (:background "palegreen4" :foreground "yellow"  :weight bold))))
   '(font-lock-builtin-face ((t (:foreground "darkseagreen"))))
   '(font-lock-comment-face ((t (:italic t :foreground "yellow" ))))
   '(font-lock-constant-face ((t (:bold t :foreground "palegreen"))))
   '(font-lock-function-name-face ((t (:bold t ))))
   '(font-lock-keyword-face ((t (:bold t :foreground "green"))))
;   '(margin-face ((t (:inverse-video t))))
;   '(font-lock-string-face ((t (:foreground "mediumseagreen"))))
   '(font-lock-string-face ((t (:italic t :foreground "#f0f0f0"))))
   '(font-lock-type-face ((t (:bold t :foreground "limegreen"))))
   '(font-lock-variable-name-face ((t (:foreground "lightgreen"))))
   )
  )

(defun theme-grizzle()
  "A subtle theme based on Aperture"
  (interactive "")
  (setq default-frame-alist      
        '((foreground-color . "black")    
          (background-color . "#dfdfdf")
          ))
  (custom-set-faces
   '(default   ((t (:background "#dfdfdf" :foreground "black" ))))
   '(cursor    ((t (:background "red"))))
   '(highlight ((t (:foreground "white" :background "steelblue"  ))))
   '(region    ((t (:foreground "white" :background "steelblue"  ))))
   '(font-lock-comment-face ((t ( :foreground "blue"))))
   '(font-lock-function-name-face ((t (:underline t :foreground "navy"))))
   '(font-lock-builtin-face ((t (:foreground "#008080"))))
   '(font-lock-string-face ((t (:foreground "blue"))))
   '(font-lock-constant-face ((t ( :foreground "black"))))
   '(font-lock-keyword-face ((t ( :foreground "brown"))))
   '(font-lock-type-face ((t (:foreground "#008080"))))
   '(font-lock-variable-name-face ((t (:foreground "navy"))))
   '(margin-face ((t (:inverse-video t ))))
   '(cperl-array-face ((t (:foreground "navy"))))
   '(cperl-hash-face ((t (:foreground "navy"))))
   '(cperl-nonoverridable-face ((t (:foreground "navy"))))
   '(modeline ((t (:background "white" :foreground "black" )))) 
   )
)


(defun theme-basic()
  "A simple color scheme"
  (interactive "")
  (setq default-frame-alist      
        '((foreground-color . "white")    
          (background-color . "#303030")
          ))
  (set-cursor-color "midnightblue")
  (set-mouse-color "midnightblue")
  (custom-set-faces
   '(default   ((t (:background "#303030" :foreground "white" ))))
   '(cursor    ((t (:background "white"   :foreground "#303030" ))))
   '(highlight ((t (:background "yellow"  :foreground "black"))))
   '(region    ((t (:background "brown"   :foreground "white"))))
   '(font-lock-comment-face ((t (:italic t :foreground "lavender"))))
   '(font-lock-function-name-face ((t (:bold t :foreground "cyan"))))
   '(font-lock-builtin-face ((t (:bold t :foreground "aquamarine"))))
   '(font-lock-string-face ((t (:foreground "lemonchiffon"))))
   '(font-lock-constant-face ((t (:bold t :foreground "lavender"))))
   '(font-lock-keyword-face ((t (:bold t :foreground "aliceblue"))))
   '(font-lock-type-face ((t (:bold t :foreground "palegreen"))))
   '(font-lock-variable-name-face ((t (:foreground "yellow"))))
;   '(margin-face ((t (:inverse-video t ))))
   '(cperl-array-face ((t (:foreground "yellow"))))
   '(cperl-hash-face ((t (:foreground "wheat"))))
   '(modeline ((t (:background "#606060" :foreground "white" :overline t :underline t)))) 
   )
  )
;
; uncomment whichever theme I currently favor
;
;(katester)
;(matrix)
;(basic)
;(grizzle)



;
; wph 20030730 added css-mode
;
(autoload 'css-mode "css-mode")
(setq auto-mode-alist
      (cons '("\\.css\\'" . css-mode) auto-mode-alist))
;
; use cperl-mode
;
;(setq auto-mode-alist
;      (cons '("\\.pm\\|\\.pl\\'" . cperl-mode) auto-mode-alist))

; ------------------------------------------------------------------
; jsp stuff
;
; functions to perform correct indentation of java code within a 
; JSP page. I can live without syntax coloring - I can't live 
; without proper indentation
;
(define-skeleton jsp-comment-start
  "Header that appears at top of jsp file"
  nil
  "<!-- start: " 
  (buffer-file-name)
  " -->")
 
(define-skeleton jsp-comment-end
  "Footer that appears at bottom of jsp file"
  nil
  "<!-- end: " 
  (buffer-file-name)
  " -->")

(setq auto-mode-alist
      (cons '("\\.jsp\\'" . html-mode) auto-mode-alist))

(defun jsp-java-sob ()
  "Return the point for the enclosing <% or nil if not present"
  (save-excursion 
    (search-backward "<%")))

(defun jsp-java-eob ()
  "Return the point for the enclosing %> or nil if not present"
  (save-excursion 
    (search-forward "%>")))

(defun jsp-in-java-debug ()
  (interactive)
  (if (jsp-in-java)
      (message "debug: in java code")
    (message "debug: not in java code")))

(defun jsp-in-java ()
  (if ()
      (c-indent-defun)
    (save-excursion
      (let* ((current-point (point))
             (start-java-tag (jsp-java-sob))
             (end-java-tag (jsp-java-eob)))
        (and (> current-point start-java-tag) 
             (< current-point end-java-tag))))))
 
(defun jsp-indent-java ()
  (interactive)
  "Indent a java block within a JSP page "
  (if (string-match ".java" (buffer-name))
      (c-indent-defun)
    (save-excursion 
      (let ((start (+ 2 (jsp-java-sob)))
            (end (jsp-java-eob) ))
        (if (string= "!" (char-to-string (char-after start)))
            (setq start (+ start 1))
          nil)
        (if (jsp-in-java)
            (progn 
              (java-mode) 
              (goto-char start)
              ;; needed for proper indentation - removed later
              (newline)    
              (insert "{")
              (newline)
              
              (goto-char end)
              ;; needed for proper indentation - removed later
              (newline)
              (insert "}") 
              (newline)
              ;; 
              ;; perform the indentation
              ;; 
              (indent-region (+ start 2) (- end 0) nil)
              ;;
              ;; now remove the text we termporarily added for indentation
              ;;
              (delete-region (- (point) 3) (point)) 
              (delete-region start (+ start 3))
              (html-mode))
          ())))))
;;
;; note: this doesn't work - 
;;        fontlock throttles the 'post-command-hook variable
;;
(defun jsp-movement-hook ()
  (let ((command-name (symbol-name this-command)))
    (if (member command-name '("previous-line" 
                               "next-line" 
                               "beginning-of-line" 
                               "end-of-line"
                               "mouse-set-point"
                               "backward-char"
                               "forward-char"
                               "backward-word"
                               "forward-word"
                               "scroll-down"
                               "scroll-up"
                               "beginning-of-buffer"
                               "end-of-buffer"))
        ;; movement occurred
        (if (jsp-in-java)
            (progn
              (message "switching to java")
              (java-mode))
          (progn
            (message "switching to html")
            (html-mode))
          )
      (message "no switch needed")
      )))

(define-skeleton html-skel
  ""
  nil  
  "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">" \n
  "<html>" \n  
  "<head>" \n  
  "<style type=\"text/css\">" \n  
  "</style>" \n  
  "<script type=\"text/javascript\">" \n  
  "</script>" \n  
  "</head>" \n  
  "<body>" \n  
  "</body>" \n  
  "</html>")
(load-library "sgml-mode")
(define-key html-mode-map "\C-h\C-b" 'html-skel)

;
; need to load cc-mode before adding key-bindings to java-mode-map
;
(load-library "cc-mode")
(define-key java-mode-map "\C-t\C-c" 'try-catch-skel)

(setq html-mode-hook
      '(lambda ()
         (define-key sgml-mode-map "\C-c\C-q"  'jsp-indent-java)
         ;;(add-hook 'post-command-hook 'jsp-movement-hook)
         ))

;---------------------------------------
; AKA (Also Known As)
;
; I need to be able to duplicate files across mutliple directories but I 
; don't have an 'ln -s' facility in my OS.
; If I edit a file in one location, I want those edits to also be saved to 
; another location automatically.
;--------------------------------------
(defvar aka-list (make-hash-table :test 'equal))
(defun aka-hook ()
  (maphash 
   (lambda (source targets) 
     ;; if the current file matches an entry in the aka-list lookup table...
     (if (string-match source buffer-file-name) 
         ;; loop over each target file/dir
         (while targets 
           (setq target (car targets))  ;; current target
           (setq targets (cdr targets)) ;; ensure loop ends
           (setq mirrored 
                 (concat target
                         (mapconcat 'identity 
                                    (split-string buffer-file-name source) "")))
           (message (concat "duplicating " buffer-file-name " to " mirrored))
           ;; need to retain buffer file name 
           (setq old buffer-file-name)
           (copy-file buffer-file-name mirrored 't)
           (setq buffer-file-name old)
           );; end targets loop
       ) ;; end if match
     );; end lambda
   aka-list)
  )
(add-hook 'after-save-hook 'aka-hook)
; To add a new hard link (works with directories or files)
;
; (puthash "c:/oldDirectory" '("c:/newDirectory") aka-list)
; (puthash "c:/oldFile" '("c:/newFile") aka-list)


(put 'upcase-region 'disabled nil)
;
; 20040813
; insert line numbers on left side of buffer
;
(defun numberize-buffer ()
  (interactive)
  (let* ((x (count-lines 1 (point-max)))
         (fmt (concat "%0" (number-to-string 
                            (length (number-to-string x))) "d: ")))
    (while (> x 0)
      (goto-line x)
      (insert (format fmt x))
      (setq x (- x 1))
      )
    )
  )
;
; 20040821
; middle-click brings up file in same window for dired mode
; (avoids multiple dired buffers popping up everywhere)
;
(defun dired-mouse-find-file-current-window (event)
  "In dired, visit the file or directory name you click on."
  (interactive "e")
  (let (file)
    (save-excursion
      (set-buffer (window-buffer (posn-window (event-end event))))
      (save-excursion
        (goto-char (posn-point (event-end event)))
        (setq file (dired-get-filename))))
    (select-window (posn-window (event-end event)))
    (find-file (file-name-sans-versions file t))))

(load-library "dired")
(define-key dired-mode-map [mouse-2] 'dired-mouse-find-file-current-window)

;
; 20040831
; Make emacs look like an IDE
;
(defvar ideflag nil)
(defun ide()
  (interactive)
  (if ideflag
      (progn
        (select-frame speedbar-attached-frame)
        (w32-send-sys-command #xf030) ;; maximize frame
        (speedbar)
        (setq ideflag nil)
        (message "ide is off")
        )
    
    (progn
      (w32-send-sys-command #xf120) ;; restore to original dimensions
      (set-frame-width  (selected-frame) (- (/ (display-pixel-width)  (frame-char-width))  45))

      (set-frame-height (selected-frame) (- (/ (display-pixel-height) (frame-char-height)) 6))

      (set-frame-position (selected-frame) (* 39 (frame-char-width)) 0)
      ;; open speedbar frame
      (speedbar)                    
    
      (set-frame-width speedbar-frame 32)
      (set-frame-height speedbar-frame (- (/ (display-pixel-height) (frame-char-height)) 6))
      (set-frame-position speedbar-frame 0 0)
      (select-frame speedbar-attached-frame)
      (setq ideflag 't)
      (message "ide is on")
      )

    )
  )

(defun theme-lcd-basic()
  "A simple color scheme"
  (interactive "")
  (setq default-frame-alist      
        '((foreground-color . "white")    
          (background-color . "#303030")
          ))
  (set-cursor-color "midnightblue")
  (set-mouse-color "midnightblue")
  (custom-set-faces
   '(default   ((t (:background "#303030" :foreground "white" ))))
   '(cursor    ((t (:background "white"   :foreground "#303030" ))))
   '(highlight ((t (:background "yellow"  :foreground "black"))))
   '(region    ((t (:background "steel blue"   :foreground "white"))))
   '(font-lock-comment-face ((t (:italic t :foreground "lavender"))))
   '(font-lock-function-name-face ((t (:foreground "green"))))
   '(font-lock-builtin-face ((t (:foreground "cyan"))))
   '(font-lock-string-face ((t (:foreground "lemonchiffon"))))
   '(font-lock-constant-face ((t (:foreground "lavender"))))
   '(font-lock-keyword-face ((t (:bold t))))
   '(font-lock-type-face ((t (:foreground "pale green"))))
   '(font-lock-variable-name-face ((t (:foreground "yellow"))))
   '(cperl-array-face ((t (:foreground "yellow"))))
   '(cperl-hash-face ((t (:foreground "yellow"))))
   '(modeline ((t (:background "#808080" :foreground "white" )))) 
   )
  )


(theme-lcd-basic)

(require 'ange-ftp)
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#303030" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 90 :width normal :foundry "unknown" :family "DejaVu Sans Mono"))))
 '(cperl-array-face ((t (:foreground "yellow"))))
 '(cperl-hash-face ((t (:foreground "yellow"))))
 '(cursor ((t (:background "white" :foreground "#303030"))))
 '(font-lock-builtin-face ((t (:foreground "cyan"))))
 '(font-lock-comment-face ((t (:italic t :foreground "lavender"))))
 '(font-lock-constant-face ((t (:foreground "lavender"))))
 '(font-lock-function-name-face ((t (:foreground "green"))))
 '(font-lock-keyword-face ((t (:bold t))))
 '(font-lock-string-face ((t (:foreground "lemonchiffon"))))
 '(font-lock-type-face ((t (:foreground "pale green"))))
 '(font-lock-variable-name-face ((t (:foreground "yellow"))))
 '(highlight ((t (:background "yellow" :foreground "black"))))
 '(mode-line ((t (:background "#808080" :foreground "white"))))
 '(region ((t (:background "steel blue" :foreground "white")))))

; 
; TinyTemplate template files
;
(add-to-list 'auto-mode-alist '("\\.ttml\\'" . html-mode))

(put 'downcase-region 'disabled nil)

(autoload 'markdown-mode "c:/home/markdown-mode.el"
  "Major mode for editing markdown files" t)

;;; Stefan Monnier <foo at acm.org>. It is the opposite of 
;;; fill-paragraph. Takes a multi-line paragraph and makes 
;;; it into a single line of text.
(defun unfill-paragraph ()
  (interactive)
  (let ((fill-column (point-max)))
    (fill-paragraph nil)))

(defun count-words (start end)
    "Print number of words in the region."
    (interactive "r")
    (save-excursion
      (save-restriction
        (narrow-to-region start end)
        (goto-char (point-min))
        (message "%s" (count-matches "\\sw+"))
		  )))

;; untabify on save
(setq-default indent-tabs-mode nil)
 ;; if indent-tabs-mode is off, untabify before saving
 (add-hook 'write-file-hooks 
          (lambda () (if (not indent-tabs-mode)
                         (untabify (point-min) (point-max)))))

