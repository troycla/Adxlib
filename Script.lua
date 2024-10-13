local gui = {}

-- Function to create a new window
function gui:MakeWindow(params)
    local window = {}
    -- Create the main frame
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.5, 0, 0.5, 0)
    frame.Position = UDim2.new(0.25, 0, 1, 0)
    frame.BackgroundColor3 = Color3.new(0, 0, 0)
    frame.BorderSizePixel = 0

    -- Add rounded corners and red outline
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 15)
    UICorner.Parent = frame

    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = Color3.new(1, 0, 0)
    UIStroke.Thickness = 2
    UIStroke.Parent = frame

    -- Add the frame to the player's PlayerGui
    frame.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    -- Create the toggle button
    local toggleButton = Instance.new("TextButton")
    toggleButton.Size = UDim2.new(0.2, 0, 0.05, 0)
    toggleButton.Position = UDim2.new(0.4, 0, 0.95, 0)  -- Center bottom of the screen
    toggleButton.Text = "Show GUI"
    toggleButton.TextColor3 = Color3.new(1, 0, 0)  -- Red text
    toggleButton.BackgroundColor3 = Color3.new(0, 0, 0)  -- Black background
    toggleButton.BorderSizePixel = 0  -- No default border
    toggleButton.Parent = screenGui

    -- Add rounded corners and red outline to the Toggle Button
    local buttonUICorner = Instance.new("UICorner")
    buttonUICorner.CornerRadius = UDim.new(0, 10)  -- Adjust the corner radius as needed
    buttonUICorner.Parent = toggleButton

    local buttonUIStroke = Instance.new("UIStroke")
    buttonUIStroke.Color = Color3.new(1, 0, 0)  -- Red outline
    buttonUIStroke.Thickness = 2  -- Adjust the thickness as needed
    buttonUIStroke.Parent = toggleButton

    -- Function to toggle the window visibility
    function window:Toggle()
        local TweenService = game:GetService("TweenService")
        local isVisible = frame.Position.Y.Scale == 0.25
        local targetPosition = isVisible and UDim2.new(0.25, 0, 1, 0) or UDim2.new(0.25, 0, 0.25, 0)
        local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = TweenService:Create(frame, tweenInfo, {Position = targetPosition})
        tween:Play()
    end

    -- Connect the button to toggle the GUI
    toggleButton.MouseButton1Click:Connect(function()
        window:Toggle()
    end)

    -- Function to create a new tab
    function window:MakeTab(params)
        local tab = {}
        local tabButton = Instance.new("TextButton")
        tabButton.Size = UDim2.new(0.5, 0, 0.1, 0)
        tabButton.Position = UDim2.new(#frame:GetChildren() * 0.5, 0, 0, 0)
        tabButton.Text = params.Name
        tabButton.TextColor3 = Color3.new(1, 0, 0)
        tabButton.BackgroundColor3 = Color3.new(0, 0, 0)
        tabButton.BorderSizePixel = 0
        tabButton.Parent = frame

        local tabFrame = Instance.new("Frame")
        tabFrame.Size = UDim2.new(1, 0, 0.9, 0)
        tabFrame.Position = UDim2.new(0, 0, 0.1, 0)
        tabFrame.BackgroundColor3 = Color3.new(0, 0, 0)
        tabFrame.Visible = false
        tabFrame.Parent = frame

        function tab:Show()
            for _, child in ipairs(frame:GetChildren()) do
                if child:IsA("Frame") and child ~= tabFrame then
                    child.Visible = false
                end
            end
            tabFrame.Visible = true
        end

        tabButton.MouseButton1Click:Connect(function()
            tab:Show()
        end)

        return tab
    end

    return window
end

-- Function to create a notification
function gui:MakeNotifi(params)
    local notification = Instance.new("TextLabel")
    notification.Size = UDim2.new(0.3, 0, 0.1, 0)
    notification.Position = UDim2.new(0.35, 0, 0.9, 0)
    notification.Text = params.Title .. "\n" .. params.Text
    notification.TextColor3 = Color3.new(1, 0, 0)
    notification.BackgroundColor3 = Color3.new(0, 0, 0)
    notification.BorderSizePixel = 0
    notification.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    wait(params.Time)
    notification:Destroy()
end

return gui
