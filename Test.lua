-- Delta Admin v1 - Compact
local Players=game:GetService("Players")
local RS=game:GetService("RunService")
local TS=game:GetService("TweenService")
local UIS=game:GetService("UserInputService")
local Light=game:GetService("Lighting")
local WS=game:GetService("Workspace")
local SG=game:GetService("StarterGui")
local SS=game:GetService("SoundService")
local VU=game:GetService("VirtualUser")
local TPS=game:GetService("TeleportService")
local Cam=WS.CurrentCamera
local LP=Players.LocalPlayer
local Mobile=UIS.TouchEnabled and not UIS.KeyboardEnabled

local Conns={}
local function tagConn(t,c) if not Conns[t] then Conns[t]={} end table.insert(Conns[t],c) end
local function cleanTag(t) if Conns[t] then for i=1,#Conns[t] do pcall(function() Conns[t][i]:Disconnect() end) end Conns[t]={} end end

local function getChar()
    local ch=LP.Character
    if not ch then return nil,nil,nil end
    return ch,ch:FindFirstChildOfClass("Humanoid"),ch:FindFirstChild("HumanoidRootPart")
end

local function notify(t)
    pcall(function() SG:SetCore("SendNotification",{Title="Delta Admin",Text=t,Duration=3}) end)
end

local SF={}
local sp1,sp2,sp3=nil,nil,nil
local curMusic=nil

pcall(function()
    local old=game:GetService("CoreGui"):FindFirstChild("DeltaAdminV1")
    if old then old:Destroy() end
end)

local Gui=Instance.new("ScreenGui")
Gui.Name="DeltaAdminV1"
Gui.ResetOnSpawn=false
Gui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
local ok=false
pcall(function() Gui.Parent=game:GetService("CoreGui") ok=true end)
if not ok then pcall(function() Gui.Parent=LP:WaitForChild("PlayerGui") end) end

local Cbg=Color3.fromRGB(10,10,20)
local Ccard=Color3.fromRGB(24,24,42)
local Cac=Color3.fromRGB(130,80,255)
local Cgr=Color3.fromRGB(45,225,105)
local Cred=Color3.fromRGB(255,60,60)
local Ctx=Color3.fromRGB(245,245,255)
local Cdim=Color3.fromRGB(130,130,160)
local Ccy=Color3.fromRGB(0,215,255)
local Cor=Color3.fromRGB(255,150,40)
local Cpk=Color3.fromRGB(255,90,200)
local Cyl=Color3.fromRGB(255,220,50)
local Csd=Color3.fromRGB(14,14,26)

local fs=Mobile and 58 or 48
local FB=Instance.new("TextButton")
FB.Size=UDim2.new(0,fs,0,fs)
FB.Position=UDim2.new(0,16,0.5,0)
FB.BackgroundColor3=Cac
FB.Text="ADM"
FB.TextColor3=Ctx
FB.TextSize=12
FB.Font=Enum.Font.GothamBold
FB.AutoButtonColor=false
FB.BorderSizePixel=0
FB.ZIndex=100
FB.Parent=Gui
local fbc=Instance.new("UICorner") fbc.CornerRadius=UDim.new(1,0) fbc.Parent=FB
local fbs=Instance.new("UIStroke") fbs.Color=Cac fbs.Thickness=2 fbs.Parent=FB

task.spawn(function()
    while true do
        pcall(function()
            local t1=TS:Create(fbs,TweenInfo.new(0.8),{Transparency=0.8}) t1:Play() t1.Completed:Wait()
            local t2=TS:Create(fbs,TweenInfo.new(0.8),{Transparency=0}) t2:Play() t2.Completed:Wait()
        end)
        task.wait(0.1)
    end
end)

local fD,fS,fP,fM=false,nil,nil,false
FB.InputBegan:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
        fD=true fM=false fS=i.Position fP=FB.Position
    end
end)
FB.InputChanged:Connect(function(i)
    if fD and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
        local d=i.Position-fS
        if d.Magnitude>5 then fM=true end
        FB.Position=UDim2.new(fP.X.Scale,fP.X.Offset+d.X,fP.Y.Scale,fP.Y.Offset+d.Y)
    end
end)
UIS.InputEnded:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then fD=false end
end)

local mW=Mobile and 410 or 390
local mH=Mobile and 480 or 460
local MF=Instance.new("Frame")
MF.Size=UDim2.new(0,0,0,0)
MF.Position=UDim2.new(0.5,0,0.5,0)
MF.AnchorPoint=Vector2.new(0.5,0.5)
MF.BackgroundColor3=Cbg
MF.BorderSizePixel=0
MF.Visible=false
MF.ZIndex=50
MF.ClipsDescendants=true
MF.Parent=Gui
local mfc=Instance.new("UICorner") mfc.CornerRadius=UDim.new(0,14) mfc.Parent=MF
local mfs=Instance.new("UIStroke") mfs.Color=Cac mfs.Thickness=2 mfs.Parent=MF

local mOpen=false
local function openM()
    if mOpen then return end
    mOpen=true MF.Visible=true MF.Size=UDim2.new(0,0,0,0)
    TS:Create(MF,TweenInfo.new(0.35,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Size=UDim2.new(0,mW,0,mH)}):Play()
end
local function closeM()
    if not mOpen then return end
    local t=TS:Create(MF,TweenInfo.new(0.25,Enum.EasingStyle.Back,Enum.EasingDirection.In),{Size=UDim2.new(0,0,0,0)})
    t:Play() t.Completed:Connect(function() MF.Visible=false mOpen=false end)
end

FB.MouseButton1Click:Connect(function()
    if fM then return end
    if mOpen then closeM() else openM() end
end)

local mD,mDS,mDP=false,nil,nil

local SB=Instance.new("Frame")
SB.Size=UDim2.new(0,52,1,0)
SB.BackgroundColor3=Csd
SB.BorderSizePixel=0
SB.ZIndex=51
SB.Parent=MF
local sbc=Instance.new("UICorner") sbc.CornerRadius=UDim.new(0,14) sbc.Parent=SB
local sbcv=Instance.new("Frame") sbcv.Size=UDim2.new(0,14,1,0) sbcv.Position=UDim2.new(1,-14,0,0) sbcv.BackgroundColor3=Csd sbcv.BorderSizePixel=0 sbcv.ZIndex=51 sbcv.Parent=SB

local Logo=Instance.new("TextLabel")
Logo.Size=UDim2.new(0,38,0,38)
Logo.Position=UDim2.new(0.5,0,0,6)
Logo.AnchorPoint=Vector2.new(0.5,0)
Logo.BackgroundColor3=Cac
Logo.Text="ADM"
Logo.TextColor3=Ctx
Logo.TextSize=10
Logo.Font=Enum.Font.GothamBold
Logo.BorderSizePixel=0
Logo.ZIndex=53
Logo.Parent=SB
local lc=Instance.new("UICorner") lc.CornerRadius=UDim.new(1,0) lc.Parent=Logo

local SBS=Instance.new("ScrollingFrame")
SBS.Size=UDim2.new(1,0,1,-52)
SBS.Position=UDim2.new(0,0,0,52)
SBS.BackgroundTransparency=1
SBS.BorderSizePixel=0
SBS.ScrollBarThickness=0
SBS.CanvasSize=UDim2.new(0,0,0,0)
SBS.ZIndex=53
SBS.Parent=SB
local sbl=Instance.new("UIListLayout") sbl.HorizontalAlignment=Enum.HorizontalAlignment.Center sbl.Padding=UDim.new(0,3) sbl.SortOrder=Enum.SortOrder.LayoutOrder sbl.Parent=SBS
sbl:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() SBS.CanvasSize=UDim2.new(0,0,0,sbl.AbsoluteContentSize.Y+8) end)

local RA=Instance.new("Frame")
RA.Size=UDim2.new(1,-52,1,0)
RA.Position=UDim2.new(0,52,0,0)
RA.BackgroundTransparency=1
RA.BorderSizePixel=0
RA.ZIndex=51
RA.Parent=MF

local TB=Instance.new("Frame") TB.Size=UDim2.new(1,0,0,36) TB.BackgroundTransparency=1 TB.BorderSizePixel=0 TB.ZIndex=52 TB.Parent=RA
TB.InputBegan:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
        mD=true mDS=i.Position mDP=MF.Position
    end
end)
TB.InputChanged:Connect(function(i)
    if mD and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
        local d=i.Position-mDS
        MF.Position=UDim2.new(mDP.X.Scale,mDP.X.Offset+d.X,mDP.Y.Scale,mDP.Y.Offset+d.Y)
    end
end)
UIS.InputEnded:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then mD=false end
end)

local TL=Instance.new("TextLabel") TL.Size=UDim2.new(1,-44,1,0) TL.Position=UDim2.new(0,8,0,0) TL.BackgroundTransparency=1 TL.BorderSizePixel=0 TL.Text="Delta Admin v1" TL.TextColor3=Ctx TL.TextSize=14 TL.Font=Enum.Font.GothamBold TL.TextXAlignment=Enum.TextXAlignment.Left TL.ZIndex=53 TL.Parent=TB

local XB=Instance.new("TextButton") XB.Size=UDim2.new(0,28,0,28) XB.Position=UDim2.new(1,-34,0,4) XB.BackgroundColor3=Cred XB.Text="X" XB.TextColor3=Ctx XB.TextSize=13 XB.Font=Enum.Font.GothamBold XB.AutoButtonColor=false XB.BorderSizePixel=0 XB.ZIndex=54 XB.Parent=TB
local xbc=Instance.new("UICorner") xbc.CornerRadius=UDim.new(0,8) xbc.Parent=XB
XB.MouseButton1Click:Connect(function() pcall(closeM) end)

local CS=Instance.new("ScrollingFrame")
CS.Size=UDim2.new(1,-6,1,-40)
CS.Position=UDim2.new(0,3,0,38)
CS.BackgroundTransparency=1
CS.BorderSizePixel=0
CS.ScrollBarThickness=3
CS.ScrollBarImageColor3=Cac
CS.CanvasSize=UDim2.new(0,0,0,0)
CS.ZIndex=52
CS.Parent=RA
local csl=Instance.new("UIListLayout") csl.HorizontalAlignment=Enum.HorizontalAlignment.Center csl.Padding=UDim.new(0,3) csl.SortOrder=Enum.SortOrder.LayoutOrder csl.Parent=CS
csl:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() CS.CanvasSize=UDim2.new(0,0,0,csl.AbsoluteContentSize.Y+10) end)

local PF={}
local SBT={}
local lo=0

local Cats={{n="Move",l="MOV"},{n="Combat",l="CMB"},{n="Troll",l="TRL"},{n="Visual",l="VIS"},{n="TP",l="TP"},{n="Modes",l="MOD"},{n="World",l="WLD"},{n="Music",l="MUS"}}

for idx,cat in ipairs(Cats) do
    local pf=Instance.new("Frame") pf.Size=UDim2.new(1,0,0,0) pf.BackgroundTransparency=1 pf.BorderSizePixel=0 pf.Visible=false pf.ZIndex=52 pf.AutomaticSize=Enum.AutomaticSize.Y pf.Parent=CS
    local pl=Instance.new("UIListLayout") pl.HorizontalAlignment=Enum.HorizontalAlignment.Center pl.Padding=UDim.new(0,3) pl.SortOrder=Enum.SortOrder.LayoutOrder pl.Parent=pf
    PF[cat.n]=pf
    local sb=Instance.new("TextButton") sb.Size=UDim2.new(0,38,0,38) sb.BackgroundColor3=Color3.fromRGB(30,30,50) sb.Text=cat.l sb.TextSize=8 sb.TextColor3=Ctx sb.Font=Enum.Font.GothamBold sb.AutoButtonColor=false sb.BorderSizePixel=0 sb.ZIndex=54 sb.LayoutOrder=idx sb.Parent=SBS
    local sbcc=Instance.new("UICorner") sbcc.CornerRadius=UDim.new(0,10) sbcc.Parent=sb
    SBT[cat.n]=sb
end

local function ShowPage(name)
    for k,f in pairs(PF) do f.Visible=(k==name) end
    TL.Text="Delta - "..name
    for k,b in pairs(SBT) do b.BackgroundColor3=(k==name) and Cac or Color3.fromRGB(30,30,50) end
end

for _,cat in ipairs(Cats) do
    SBT[cat.n].MouseButton1Click:Connect(function() pcall(function() ShowPage(cat.n) end) end)
end

local function nO() lo=lo+1 return lo end

local function Sec(p,t)
    local pg=PF[p] if not pg then return end
    local f=Instance.new("Frame") f.Size=UDim2.new(1,-6,0,22) f.BackgroundTransparency=1 f.BorderSizePixel=0 f.ZIndex=52 f.LayoutOrder=nO() f.Parent=pg
    local l=Instance.new("TextLabel") l.Size=UDim2.new(1,0,1,0) l.BackgroundTransparency=1 l.BorderSizePixel=0 l.Text="  "..string.upper(t) l.TextColor3=Cac l.TextSize=11 l.Font=Enum.Font.GothamBold l.TextXAlignment=Enum.TextXAlignment.Left l.ZIndex=53 l.Parent=f
end

local function Tog(p,name,desc,col,cb)
    local pg=PF[p] if not pg then return end
    local isOn=false
    local card=Instance.new("Frame") card.Size=UDim2.new(1,-6,0,50) card.BackgroundColor3=Ccard card.BorderSizePixel=0 card.ZIndex=52 card.LayoutOrder=nO() card.Parent=pg
    local cc=Instance.new("UICorner") cc.CornerRadius=UDim.new(0,10) cc.Parent=card
    local st=Instance.new("Frame") st.Size=UDim2.new(0,3,1,-6) st.Position=UDim2.new(0,3,0,3) st.BackgroundColor3=col st.BorderSizePixel=0 st.ZIndex=53 st.Parent=card
    local stc=Instance.new("UICorner") stc.CornerRadius=UDim.new(0,2) stc.Parent=st
    local nl=Instance.new("TextLabel") nl.Size=UDim2.new(1,-62,0,20) nl.Position=UDim2.new(0,12,0,4) nl.BackgroundTransparency=1 nl.BorderSizePixel=0 nl.Text=name nl.TextColor3=Ctx nl.TextSize=12 nl.Font=Enum.Font.GothamBold nl.TextXAlignment=Enum.TextXAlignment.Left nl.TextTruncate=Enum.TextTruncate.AtEnd nl.ZIndex=53 nl.Parent=card
    local dl=Instance.new("TextLabel") dl.Size=UDim2.new(1,-62,0,14) dl.Position=UDim2.new(0,12,0,24) dl.BackgroundTransparency=1 dl.BorderSizePixel=0 dl.Text=desc dl.TextColor3=Cdim dl.TextSize=9 dl.Font=Enum.Font.Gotham dl.TextXAlignment=Enum.TextXAlignment.Left dl.TextTruncate=Enum.TextTruncate.AtEnd dl.ZIndex=53 dl.Parent=card
    local sw=Instance.new("TextButton") sw.Size=UDim2.new(0,40,0,20) sw.Position=UDim2.new(1,-48,0.5,-10) sw.BackgroundColor3=Color3.fromRGB(60,60,80) sw.Text="" sw.AutoButtonColor=false sw.BorderSizePixel=0 sw.ZIndex=54 sw.Parent=card
    local swc=Instance.new("UICorner") swc.CornerRadius=UDim.new(1,0) swc.Parent=sw
    local kn=Instance.new("Frame") kn.Size=UDim2.new(0,16,0,16) kn.Position=UDim2.new(0,2,0.5,-8) kn.BackgroundColor3=Ctx kn.BorderSizePixel=0 kn.ZIndex=55 kn.Parent=sw
    local knc=Instance.new("UICorner") knc.CornerRadius=UDim.new(1,0) knc.Parent=kn
    sw.MouseButton1Click:Connect(function()
        pcall(function()
            isOn=not isOn
            if isOn then
                TS:Create(kn,TweenInfo.new(0.2),{Position=UDim2.new(0,22,0.5,-8)}):Play()
                TS:Create(sw,TweenInfo.new(0.2),{BackgroundColor3=Cgr}):Play()
            else
                TS:Create(kn,TweenInfo.new(0.2),{Position=UDim2.new(0,2,0.5,-8)}):Play()
                TS:Create(sw,TweenInfo.new(0.2),{BackgroundColor3=Color3.fromRGB(60,60,80)}):Play()
            end
            cb(isOn)
        end)
    end)
end

local function TSlider(p,name,desc,col,mn,mx,def,cb)
    local pg=PF[p] if not pg then return end
    local isOn=false local val=def
    local card=Instance.new("Frame") card.Size=UDim2.new(1,-6,0,70) card.BackgroundColor3=Ccard card.BorderSizePixel=0 card.ZIndex=52 card.LayoutOrder=nO() card.Parent=pg
    local cc=Instance.new("UICorner") cc.CornerRadius=UDim.new(0,10) cc.Parent=card
    local st=Instance.new("Frame") st.Size=UDim2.new(0,3,1,-6) st.Position=UDim2.new(0,3,0,3) st.BackgroundColor3=col st.BorderSizePixel=0 st.ZIndex=53 st.Parent=card
    local stc=Instance.new("UICorner") stc.CornerRadius=UDim.new(0,2) stc.Parent=st
    local nl=Instance.new("TextLabel") nl.Size=UDim2.new(0.55,0,0,16) nl.Position=UDim2.new(0,12,0,4) nl.BackgroundTransparency=1 nl.BorderSizePixel=0 nl.Text=name nl.TextColor3=Ctx nl.TextSize=12 nl.Font=Enum.Font.GothamBold nl.TextXAlignment=Enum.TextXAlignment.Left nl.TextTruncate=Enum.TextTruncate.AtEnd nl.ZIndex=53 nl.Parent=card
    local dl=Instance.new("TextLabel") dl.Size=UDim2.new(0.55,0,0,12) dl.Position=UDim2.new(0,12,0,20) dl.BackgroundTransparency=1 dl.BorderSizePixel=0 dl.Text=desc dl.TextColor3=Cdim dl.TextSize=9 dl.Font=Enum.Font.Gotham dl.TextXAlignment=Enum.TextXAlignment.Left dl.TextTruncate=Enum.TextTruncate.AtEnd dl.ZIndex=53 dl.Parent=card
    local ol=Instance.new("TextLabel") ol.Size=UDim2.new(0,36,0,14) ol.Position=UDim2.new(1,-82,0,4) ol.BackgroundTransparency=1 ol.BorderSizePixel=0 ol.Text="OFF" ol.TextColor3=Cred ol.TextSize=10 ol.Font=Enum.Font.GothamBold ol.TextXAlignment=Enum.TextXAlignment.Right ol.ZIndex=53 ol.Parent=card
    local vl=Instance.new("TextLabel") vl.Size=UDim2.new(0,40,0,14) vl.Position=UDim2.new(1,-46,0,4) vl.BackgroundTransparency=1 vl.BorderSizePixel=0 vl.Text=tostring(def) vl.TextColor3=Cac vl.TextSize=11 vl.Font=Enum.Font.GothamBold vl.TextXAlignment=Enum.TextXAlignment.Right vl.ZIndex=53 vl.Parent=card
    local ta=Instance.new("TextButton") ta.Size=UDim2.new(1,0,0,36) ta.BackgroundTransparency=1 ta.BorderSizePixel=0 ta.Text="" ta.AutoButtonColor=false ta.ZIndex=56 ta.Parent=card
    ta.MouseButton1Click:Connect(function()
        pcall(function()
            isOn=not isOn
            ol.Text=isOn and "ON" or "OFF"
            ol.TextColor3=isOn and Cgr or Cred
            cb(isOn,val)
        end)
    end)
    local tr=Instance.new("Frame") tr.Size=UDim2.new(1,-20,0,7) tr.Position=UDim2.new(0,10,0,48) tr.BackgroundColor3=Color3.fromRGB(40,40,60) tr.BorderSizePixel=0 tr.ZIndex=53 tr.Parent=card
    local trc=Instance.new("UICorner") trc.CornerRadius=UDim.new(1,0) trc.Parent=tr
    local fl=Instance.new("Frame") fl.Size=UDim2.new((def-mn)/(mx-mn),0,1,0) fl.BackgroundColor3=col fl.BorderSizePixel=0 fl.ZIndex=54 fl.Parent=tr
    local flc=Instance.new("UICorner") flc.CornerRadius=UDim.new(1,0) flc.Parent=fl
    local sa=Instance.new("TextButton") sa.Size=UDim2.new(1,0,0,22) sa.Position=UDim2.new(0,0,0,42) sa.BackgroundTransparency=1 sa.BorderSizePixel=0 sa.Text="" sa.AutoButtonColor=false sa.ZIndex=57 sa.Parent=card
    local sD=false
    local function upd(pos)
        pcall(function()
            local w=tr.AbsoluteSize.X if w<=0 then return end
            local r=math.clamp((pos.X-tr.AbsolutePosition.X)/w,0,1)
            val=math.floor(mn+r*(mx-mn))
            fl.Size=UDim2.new(r,0,1,0)
            vl.Text=tostring(val)
            if isOn then cb(isOn,val) end
        end)
    end
    sa.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then sD=true upd(i.Position) end end)
    sa.InputChanged:Connect(function(i) if sD and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then upd(i.Position) end end)
    UIS.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then sD=false end end)
end

local function Btn(p,name,desc,col,cb)
    local pg=PF[p] if not pg then return end
    local card=Instance.new("TextButton") card.Size=UDim2.new(1,-6,0,46) card.BackgroundColor3=Ccard card.Text="" card.AutoButtonColor=false card.BorderSizePixel=0 card.ZIndex=52 card.LayoutOrder=nO() card.Parent=pg
    local cc=Instance.new("UICorner") cc.CornerRadius=UDim.new(0,10) cc.Parent=card
    local st=Instance.new("Frame") st.Size=UDim2.new(0,3,1,-6) st.Position=UDim2.new(0,3,0,3) st.BackgroundColor3=col st.BorderSizePixel=0 st.ZIndex=53 st.Parent=card
    local stc=Instance.new("UICorner") stc.CornerRadius=UDim.new(0,2) stc.Parent=st
    local nl=Instance.new("TextLabel") nl.Size=UDim2.new(1,-16,0,18) nl.Position=UDim2.new(0,12,0,4) nl.BackgroundTransparency=1 nl.BorderSizePixel=0 nl.Text=name nl.TextColor3=Ctx nl.TextSize=12 nl.Font=Enum.Font.GothamBold nl.TextXAlignment=Enum.TextXAlignment.Left nl.TextTruncate=Enum.TextTruncate.AtEnd nl.ZIndex=53 nl.Parent=card
    local dl=Instance.new("TextLabel") dl.Size=UDim2.new(1,-16,0,12) dl.Position=UDim2.new(0,12,0,24) dl.BackgroundTransparency=1 dl.BorderSizePixel=0 dl.Text=desc dl.TextColor3=Cdim dl.TextSize=9 dl.Font=Enum.Font.Gotham dl.TextXAlignment=Enum.TextXAlignment.Left dl.TextTruncate=Enum.TextTruncate.AtEnd dl.ZIndex=53 dl.Parent=card
    card.MouseButton1Click:Connect(function()
        pcall(function()
            TS:Create(card,TweenInfo.new(0.1),{BackgroundColor3=col}):Play()
            task.delay(0.15,function() pcall(function() TS:Create(card,TweenInfo.new(0.2),{BackgroundColor3=Ccard}):Play() end) end)
            cb()
        end)
    end)
end

-- MOVE
lo=0
Sec("Move","ПОЛЁТ")
TSlider("Move","Полёт","Летай по карте",Ccy,20,500,80,function(on,val)
    pcall(function()
        cleanTag("fly")
        local _,_,hrp=getChar() if not hrp then return end
        if on then
            local o=hrp:FindFirstChild("_FBV") if o then o:Destroy() end
            local o2=hrp:FindFirstChild("_FBG") if o2 then o2:Destroy() end
            local bv=Instance.new("BodyVelocity") bv.Name="_FBV" bv.MaxForce=Vector3.new(1e6,1e6,1e6) bv.Velocity=Vector3.new(0,0,0) bv.Parent=hrp
            local bg=Instance.new("BodyGyro") bg.Name="_FBG" bg.MaxTorque=Vector3.new(1e6,1e6,1e6) bg.D=100 bg.P=1e4 bg.Parent=hrp
            tagConn("fly",RS.RenderStepped:Connect(function()
                pcall(function()
                    local _,h,r=getChar() if not r then return end
                    local b=r:FindFirstChild("_FBV") local g=r:FindFirstChild("_FBG") if not b or not g then return end
                    g.CFrame=Cam.CFrame
                    local m=h and h.MoveDirection or Vector3.new(0,0,0)
                    local u=0
                    pcall(function() if UIS:IsKeyDown(Enum.KeyCode.Space) then u=1 end if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then u=-1 end end)
                    local v=Vector3.new(0,0,0) if m.Magnitude>0 then v=m.Unit*val end
                    b.Velocity=v+Vector3.new(0,u*val,0)
                end)
            end))
        else
            local _,_,r=getChar() if r then local x=r:FindFirstChild("_FBV") if x then x:Destroy() end local y=r:FindFirstChild("_FBG") if y then y:Destroy() end end
        end
    end)
end)
Sec("Move","СКОРОСТЬ")
TSlider("Move","Скорость","Скорость ходьбы",Cgr,16,500,16,function(on,val)
    pcall(function() cleanTag("ws")
        if on then tagConn("ws",RS.Heartbeat:Connect(function() pcall(function() local _,h=getChar() if h then h.WalkSpeed=val end end) end))
