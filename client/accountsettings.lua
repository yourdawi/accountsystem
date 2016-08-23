--[[
#######################################
#######################################
###########Erstellt von Dawi###########
##########github.com/yourdawi##########
##############yourdawi.de##############
#######################################
#######################################
]]

--[[
Sehr geehrter "Hacker", "Bugsucher" oder sonstiges.
Wenn du dich freust "OHHHH setElementData WAS EIN IDIOT!"
Dann muss ich dich enttäuschen, dies ist nur für die Synchronisation, ist leichter.
Wenn du code nachladen kannst, dies bringt nichts.
Gib dir Adminlvl 5000, mir egal, kannst das Admin GUI sehen, hier übrigens auch.
Du kannst es dir übrigens auch sparen jede Datei nach dem "Securetoken" zu durchsuchen, der ist Serverseitig erstellt
und verschlüsselt worden. Er wird nur einmal Serverseitig in seinem Orginal ausgegeben und nichteinmal die Datenbank kennt das Orginal.
Ebenfalls kann er nicht nocheinmal genauso generiert werden.
Viel Spaß auf dem Server, Gruß Dawi.
]]
local sx,sy = guiGetScreenSize()
local sxx,syy = 1280,720
addEvent("codeCheckErgebnis",true)

function openAccountSettings()
  if isElement(accounteinstellungen) then
    destroyElement(accounteinstellungen)
    showCursor(false)
  else
    showCursor(true)
  accounteinstellungen = guiCreateWindow(379/sxx*sx, 229/syy*sy, 485/sxx*sx, 323/syy*sy, "Account Einstellungen", false)
  guiWindowSetSizable(accounteinstellungen, false)

  tabpanel = guiCreateTabPanel(9/sxx*sx, 29/syy*sy, 466/sxx*sx, 284/syy*sy, false, accounteinstellungen)

  taballgemein = guiCreateTab("Allgemein", tabpanel)

  SaveAllgemein = guiCreateButton(188/sxx*sx, 211/syy*sy, 94/sxx*sx, 39/syy*sy, "Save", false, taballgemein)
  if tonumber(getElementData(localPlayer,"AutoLogin")) == 0 then
  AutoLoginCheckbox = guiCreateCheckBox(17/sxx*sx, 16/syy*sy, 15/sxx*sx, 15/syy*sy, "", false, false, taballgemein)
else
  AutoLoginCheckbox = guiCreateCheckBox(17/sxx*sx, 16/syy*sy, 15/sxx*sx, 15/syy*sy, "", true, false, taballgemein)
end
  AutoLoginLabel = guiCreateLabel(38/sxx*sx, 14/syy*sy, 108/sxx*sx, 17/syy*sy, "Auto-Login (Serial)", false, taballgemein)
  passwortaenderneditbox = guiCreateEdit(21/sxx*sx, 80/syy*sy, 177/sxx*sx, 28/syy*sy, "", false, taballgemein)
  wiederholeneditbox = guiCreateEdit(21/sxx*sx, 141/syy*sy, 177/sxx*sx, 28/syy*sy, "", false, taballgemein)
  passwortaendern = guiCreateLabel(23/sxx*sx, 51/syy*sy, 165/sxx*sx, 19/syy*sy, "Passwort ändern", false, taballgemein)
  wiederholen = guiCreateLabel(23/sxx*sx, 118/syy*sy, 165/sxx*sx, 19/syy*sy, "Wiederholen", false, taballgemein)
  tokeneditbox = guiCreateEdit(222/sxx*sx, 98/syy*sy, 215/sxx*sx, 29/syy*sy, "", false, taballgemein)
  tokeninfo = guiCreateLabel(222/sxx*sx, 26/syy*sy, 244/sxx*sx, 64/syy*sy, "Bitte gib hier deinen Token ein.\nOhne kannst du keine Einstellungen treffen.\nSollte er verloren sein, bitte wende dich\nan einen Administrator!", false, taballgemein)
    addEventHandler("onClientGUIClick",SaveAllgemein,
    function()
      triggerServerEvent("checkSecureCode",localPlayer,guiGetText(tokeneditbox))
      addEventHandler("codeCheckErgebnis",getRootElement(),
      function(state)
        if state == true then
          if guiGetText(passwortaenderneditbox) ~= "" then
          if guiGetText(passwortaenderneditbox) == guiGetText(wiederholeneditbox) then
            triggerServerEvent("UserChangePassword",localPlayer,guiGetText(passwortaenderneditbox),guiGetText(tokeneditbox))
          end
        else
          if guiCheckBoxGetSelected(AutoLoginCheckbox) then
            triggerServerEvent("AutoLoginChange",localPlayer,true)
          else
            triggerServerEvent("AutoLoginChange",localPlayer,false)
          end
        end
      end
      end)
    end,false)
  if getElementData(localPlayer,"VIP") >= 1 then
  tabvip = guiCreateTab("VIP", tabpanel)
  end
  if getElementData(localPlayer,"Adminlvl") >= 1 then
  tabadmin = guiCreateTab("Admin", tabpanel)

  passwortaendernlabel = guiCreateLabel(9/sxx*sx, 13/syy*sy, 117/sxx*sx, 28/syy*sy, "Passwort ändern", false, tabadmin)
  spielername = guiCreateLabel(10/sxx*sx, 43/syy*sy, 116/sxx*sx, 25/syy*sy, "Spielername", false, tabadmin)
  spielernameeditbox = guiCreateEdit(9/sxx*sx, 78/syy*sy, 117/sxx*sx, 26/syy*sy, "", false, tabadmin)
  passwortlabel = guiCreateLabel(10/sxx*sx, 114/syy*sy, 111/sxx*sx, 27/syy*sy, "Passwort", false, tabadmin)
  passwortedit = guiCreateEdit(11/sxx*sx, 139/syy*sy, 115/sxx*sx, 26/syy*sy, "", false, tabadmin)
  pwchangesavebutton = guiCreateButton(21/sxx*sx, 183/syy*sy, 90/sxx*sx, 36/syy*sy, "Save", false, tabadmin)
        addEventHandler("onClientGUIClick",pwchangesavebutton,
        function()
            if #guiGetText(passwortedit) >= 5 then
              triggerServerEvent("adminChangePassword",localPlayer,guiGetText(spielernameeditbox),guiGetText(passwortedit))
            else
              outputChatBox("Mindestens 5 Zeichen!",255,0,0)
            end
        end,false)
  end
end
end

addCommandHandler("accountsettings",openAccountSettings)
bindKey("F3","down",openAccountSettings)
