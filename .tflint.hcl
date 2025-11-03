config {
  call_module_type = "all"
}
plugin "terraform" {
  enabled = true
  preset  = "recommended"
}
plugin "azurerm" {
    enabled = true
    version = "0.29.0"
    source  = "github.com/terraform-linters/tflint-ruleset-azurerm"
}
rule "terraform_required_version" {
    enabled = false
}

plugin "fabric" {
    enabled = true
    version = "0.1.0"
    source  = "github.com/RuneORakeie/tflint-ruleset-fabric"
    signing_key = <<-KEY
-----BEGIN PGP PUBLIC KEY BLOCK-----

mDMEaPIddRYJKwYBBAHaRw8BAQdA97T9Pw1tHwmuoCHx5Od2jRErjYQLMkGtjzHa
n/OtVO+0LlJ1bmUgT3ZsaWVuIFJha2VpZSA8cnVuZS5yYWtlaWVAdGlldG9ldnJ5
LmNvbT6ImQQTFgoAQRYhBDnXUAR+SpStNuTHwcE/gmmRiGC6BQJo8h11AhsDBQkD
wmcABQsJCAcCAiICBhUKCQgLAgQWAgMBAh4HAheAAAoJEME/gmmRiGC6clQBAN4b
xNef3oASq2YWhyDJGoKavDGsTr9CJZkZ66EBPx+zAQDhrFEpylND2qtxQG8x0O5C
cXAcWbXr1DcxbJMEngtZCLg4BGjyHXUSCisGAQQBl1UBBQEBB0B7RETmxgBs7+xU
+MC1lY8ns3V2jnkf/JDAqDymDCcEcgMBCAeIfgQYFgoAJhYhBDnXUAR+SpStNuTH
wcE/gmmRiGC6BQJo8h11AhsMBQkDwmcAAAoJEME/gmmRiGC6XP4A/2x6serOfr3l
8uRNXHoxoKfKAxtcT4JjXGb3NMuc1DfVAP4zy+0wZb8/6jpRriVphm63Y0LjVFv0
3mMMNhrYbuc0AA==
=4jLr
-----END PGP PUBLIC KEY BLOCK-----
KEY
}