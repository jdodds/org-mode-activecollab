(add-to-list 'load-path ".")
(require 'ert)
(require 'org-feed-active-collab)

(ert-deftest ac-formatter-test-feed-entry-formatting ()
  (let ((entry
	 (list
	  :guid "https://www.example.com/ac/index.php?path_info=projects/731/tickets/3828"
	  :pubDate "Thu, 17 Nov 2011 18:35:13 +0000"
	  :description "<![CDATA[
<p> <b>Project:</b> <a href=\"https://www.example.com/ac/index.php?path_info=projects/731\" class=\"project_link\">FOO: 0013 - Project Common </a><br /> <b>Ticket:</b> <a href=\"https://www.example.com/ac/index.php?path_info=projects/731/tickets/3828\">Research domain registrars and their APIs</a><br /> <b>Priority:</b> Normal<br /> <b>Due on:</b> Dec 01. 2011<br /> <b>Assignees:</b> <a href=\"https://www.example.com/ac/index.php?path_info=people/234#user93\">Tester McTesterson</a> is responsible. </p> <hr /> <p>research domain/SSL alternatives to SRS Plus that meet our API/automation needs. Make a recommendation to Henry Hatford as to service to move to (to be implemented in future milestone). in meantime, can apply SSL process be handed to not-Jimmy Dalton?</p>
]]>"
	  :link "https://www.example.com/ac/index.php?path_info=projects/731/tickets/3828"
	  :title "[FOO: 0013 - Project Common] Ticket \"Research domain registrars and their APIs\"")))
    (let ((result (org-feed-parse-activecollab-entry entry)))
      (ert-should (equal result
			 "* TODO [[https://www.example.com/ac/index.php?path_info=projects/731/tickets/3828][Research domain registrars and their APIs]]\nDEADLINE: <2011-12-01 Thu>\nresearch domain/SSL alternatives to SRS Plus that meet our API/automation needs. Make a recommendation to Henry Hatford as to service to move to (to be implemented in future milestone). in meantime, can apply SSL process be handed to not-Jimmy Dalton?")))))

(ert-deftest ac-formatter-test-entry-with-no-due-date ()
  (let ((entry
	 (list
	  :guid "https://www.example.com/ac/index.php?path_info=projects/435/tickets/1234"
	  :description "<![CDATA[
<p> <b>Project:</b> <a href=\"https://www.example.com/ac/index.php?path_info=projects/435\" class=\"project_link\">FOO: 0013 - Project Common </a><br /> <b>Ticket:</b> <a href=\"https://www.example.com/ac/index.php?path_info=projects/435/tickets/1234\">Implement Frabjobber Bozzler rules</a><br /> <b>Priority:</b> Low<br /> <b>Assignees:</b> <a href=\"https://www.example.com/ac/index.php?path_info=people/354#user36\">Tester McTesterson</a> is responsible. Other assignees: <a href=\"https://www.example.com/ac/index.php?path_info=people/354#user18\">Bill Brasky</a>. </p> <hr /> Should rules live in the bumbler directory?]]>")))
    (let ((result (org-feed-parse-activecollab-entry entry)))
      (ert-should (equal
		   result
		   "* TODO [[https://www.example.com/ac/index.php?path_info=projects/435/tickets/1234][Implement Frabjobber Bozzler rules]]\n Should rules live in the bumbler directory?")))))

