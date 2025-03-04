# Generated on 03/04/2025 10:12:41 by .\build\orca\Update-OrcaTests.ps1

Describe "ORCA" -Tag "ORCA", "ORCA140", "EXO", "Security", "All" {
    It "ORCA140: High Confidence Spam action set to Quarantine message." {
        $result = Test-ORCA140

        if($null -ne $result) {
            $result | Should -Be $true -Because "High Confidence Spam action set to Quarantine message."
        }
    }
}
