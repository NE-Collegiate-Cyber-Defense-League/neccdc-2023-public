﻿$password = "QBy2Y6dYlZ0W"
Install-ADcsCertificationAuthority -CAType EnterpriseRootCa -CertFile C:\ProgramData\Prometheus-RootCA-Cert.pfx -CertFilePassword ($Password|ConvertTo-SecureString -AsPlainText -Force) –DatabaseDirectory C:\windows\system32\certLog -LogDirectory C:\windows\system32\certLog –Force