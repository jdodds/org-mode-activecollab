(defun org-feed-parse-activecollab-entry (entry)
  "Parses an ActiveCollab RSS entry and returns an Org outline node with useful
  information." 
  (let ((desc (plist-get entry :description))
	(link (plist-get entry :guid))
	(deadline nil)
	(headline nil)
	(description nil))
    (if (string-match-p "Due on:" desc)
	(progn
	  (string-match "<b>Due on:</b>\\([^<]+\\)" desc)
	  (setq deadline (match-string 1 desc))))
    (string-match
     "\\(?:Ticket\\|Milestone\\):</b> <a[^>]+>\\([^<]+\\)</a"
     desc)
    (setq headline (match-string 1 desc))
    (string-match "<hr />\\(?:\n\\|<p>\\|\\\\n\\| \\)+\\([^]<]+\\)" desc)
    (setq description (match-string 1 desc))
    (concat
     "* TODO [[" link "][" headline "]]"
     (if (not (null deadline))
	 (concat
	  "\nDEADLINE: <"
	  (format-time-string
	   "%Y-%m-%d %a"
	   (apply 'encode-time
		  (org-fix-decoded-time (parse-time-string deadline))))
	  ">")
       "")
     "\n"
     description)))
  
(provide 'org-feed-active-collab)
