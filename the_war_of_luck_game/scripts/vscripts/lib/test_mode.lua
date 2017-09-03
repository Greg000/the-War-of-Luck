if TestMode == nil then
	TestMode = class({})
end


function TestMode:IsTestMode()
    return TestMode.is_test_mode
end

function TestMode:InitializeTestMode()
    TestMode.is_test_mode = true
end

