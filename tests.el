(add-to-list 'load-path ".")
(require 'ert)
(require 'org-feed-active-collab-formatter)

(ert-deftest ac-formatter-formats ()
  (let ((entry
	 (list
	  :guid "https://www.example.com/ac/index.php?path_info=projects/731/tickets/3828"
	  :pubDate "Thu, 17 Nov 2011 18:35:13 +0000"
	  :description "<![CDATA[
<p> <b>Project:</b> <a href=\"https://www.example.com/ac/index.php?path_info=projects/731\" class=\"project_link\">FOO: 0013 - Project Common </a><br /> <b>Ticket:</b> <a href=\"https://www.example.com/ac/index.php?path_info=projects/731/tickets/3828\">Research domain registrars and their APIs</a><br /> <b>Priority:</b> Normal<br /> <b>Due on:</b> Dec 01. 2011<br /> <b>Assignees:</b> <a href=\"https://www.example.com/ac/index.php?path_info=people/234#user93\">Tester McTesterson</a> is responsible. </p> <hr /> <p>research domain/SSL alternatives to SRS Plus that meet our API/automation needs. Make a recommendation to Henry Hatford as to service to move to (to be implemented in future milestone). in meantime, can apply SSL process be handed to not-Jimmy Dalton?</p>
]]>"
	  :link "https://www.example.com/ac/index.php?path_info=projects/731/tickets/3828"
	  :title "[FOO: 0013 - Project Common] Ticket \"Research domain registrars and their APIs\"")))
    (let ((result (org-feed-active-collab-formatter entry)))
      (should (equal result
		     "* TODO [[https://www.example.com/ac/index.php?path_info=projects/731/tickets/3828][Research domain registrars and their APIs]]\nDEADLINE: <2011-12-01 Thu>\nresearch domain/SSL alternatives to SRS Plus that meet our API/automation needs. Make a recommendation to Henry Hatford as to service to move to (to be implemented in future milestone). in meantime, can apply SSL process be handed to not-Jimmy Dalton?")))))
    
