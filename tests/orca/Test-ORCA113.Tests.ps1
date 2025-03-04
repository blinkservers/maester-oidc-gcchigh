# Generated on 03/04/2025 10:12:40 by .\build\orca\Update-OrcaTests.ps1

Describe "ORCA" -Tag "ORCA", "ORCA113", "EXO", "Security", "All" {
    It "ORCA113: AllowClickThrough is disabled in Safe Links policies." {
        $result = Test-ORCA113

        if($null -ne $result) {
            $result | Should -Be $true -Because "AllowClickThrough is disabled in Safe Links policies."
        }
    }
}
