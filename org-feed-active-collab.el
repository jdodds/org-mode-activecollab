(defun org-feed-parse-activecollab-entry (entry)
  "Parses an ActiveCollab RSS entry and returns an Org outline node with useful
  information."
  (require 'xml)
  (let ((desc (plist-get entry :description))
	(link (plist-get entry :guid)))
    (let ((due-date (not (null (string-match "Due on:" desc)))))
      (if due-date
	  (progn
	    (string-match
	     "Ticket:</b> <[^>]+>\\([^<]+\\).+<b>Due on:</b>\\([^<]+\\).+<hr /> <p>\\([^<]+\\)<"
	     desc)
	    (let ((headline (match-string 1 desc))
		  (deadline (match-string 2 desc))
		  (description (match-string 3 desc)))

	      (concat
	       "* TODO [["
	       link
	       "]["
	       headline
	       "]]"
	       "\nDEADLINE: <"
	       (format-time-string
		"%Y-%m-%d %a"
		(apply 'encode-time
		       (org-fix-decoded-time (parse-time-string deadline))))
	       ">\n"
	       description)))
	(progn
	  (string-match
	   "Ticket:</b> <[^>]+>\\([^<]+\\).+<hr />\\([^]]+\\)"
	   desc)
	  (let ((headline (match-string 1 desc))
		(description (match-string 2 desc)))
	    (concat
	     "* TODO [["
	     link
	     "]["
	     headline
	     "]]"
	     "\n"
	     description)))))))
      


  
(provide 'org-feed-active-collab)
