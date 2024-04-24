"""
Copyright (c) 2024 Cisco and/or its affiliates.
This software is licensed to you under the terms of the Cisco Sample
Code License, Version 1.1 (the "License"). You may obtain a copy of the
License at
https://developer.cisco.com/docs/licenses
All use of the material herein must be in accordance with the terms of
the License. All rights not expressly granted by the License are
reserved. Unless required by applicable law or agreed to separately in
writing, software distributed under the License is distributed on an "AS
IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express
or implied.
"""

data "http" "example" {
  url = ""

  # Optional request headers
  request_headers = {
    Accept = "application/json"
    X-Nd-Username = ""
    X-Nd-Apikey = ""
  }
  insecure = true
  method = "GET"
}


locals {
  poap_list = jsondecode(data.http.example.response_body)
  poap_map = tomap({
    for device in local.poap_list :
      device.serialNumber => device
  })

  switches = csvdecode(file("${path.module}/poap_inventory.csv"))

  switch_list = [for switch in local.switches :
  {
    "hostname" : switch.Hostname,
    "imagePolicy" : "",
    "ipAddress" : switch.IP,
    "password" : switch.Password,
    "role" : switch.Role,
    "discoveryAuthProtocol" : 0,
    "serialNumber": switch.SerialNumber,
    "model": switch.Model,
    "version": switch.Version,
    "data": "",
    "reAdd": false,
    "seedSwitchFlag": false,
    "fingerprint" : local.poap_map[switch.SerialNumber].fingerprint,
    "publicKey" : local.poap_map[switch.SerialNumber].publicKey
  }
  ]

  json_input = jsonencode(local.switch_list)
}

terraform {
  required_providers {
    dcnm = {
      source = "CiscoDevNet/dcnm"
    }
  }
}

#configure provider with your cisco dcnm/ndfc credentials.
provider "dcnm" {
  username = ""
  password = ""
  url      = ""
  insecure = true
  platform = "nd"
}

resource "dcnm_rest" "poap_creation" {
  path    = "/appcenter/cisco/ndfc/api/v1/lan-fabric/rest/control/fabrics/VXLAN-CML/inventory/poap"
  method  = "POST"
  payload = local.json_input
}