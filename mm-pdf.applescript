# Saves current document open in foreground app as PDF using the Print dialog "Save as PDF" option

# value to limit how long we wait for a given dialog or menu popup
set maxloops to 100

set process_name to "MailMate"
activate application process_name

tell application "System Events"
	tell process process_name
		
		# Open the print dialog
		keystroke "p" using command down
		
		# Wait until the Print dialog opens before proceeding
		set prdlg to 0 # Initialize loop variable
		set lcnt to 0 # Counter to prevent infinit loops
		repeat until prdlg is not 0
			# Determine if the app is using a dialog or a sheet for print options and then create reference to dialog or sheet for use later
			if exists window "Print" then
				# Current App uses the Print dialog (not sheet)
				set prdlg to 1
				set prdlgref to a reference to window "Print"
				set wtype to "dlg"
			else if exists sheet 1 of window 1 then
				# Current App uses the Print sheet (not dialog)
				set prdlg to 1
				set prdlgref to a reference to sheet 1 of window 1
				set wtype to "sht"
			end if
			set lcnt to lcnt + 1
			if (lcnt) > maxloops then
				
				return
			end if
		end repeat
		
		# Expand the "PDF" menu button (must be expanded before the menu is referencable)
		click menu button "PDF" of prdlgref
		
		# Wait until the Menu button menu is created before proceeding
		set lcnt to 0
		repeat until exists menu item "Save as PDFÉ" of menu 1 of menu button "PDF" of prdlgref
			set lcnt to lcnt + 1
			if (lcnt) > maxloops then
				
				return
			end if
		end repeat
		
		# Select the "Save as PDF" menu item
		click menu item "Save as PDFÉ" of menu 1 of menu button "PDF" of prdlgref
		
		# Wait until the Save dialog opens before proceeding
		set lcnt to 0
		repeat until exists window "Save"
			set lcnt to lcnt + 1
			if (lcnt) > maxloops then
				return
			end if
		end repeat
		
	end tell
end tell