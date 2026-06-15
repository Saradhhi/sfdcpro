#!/bin/bash
set -e

sf org assign permissionset --targetusername SCRATCH --permset Admin
sf org assign permissionset --targetusername SCRATCH --permset Sales
sf org assign permissionset --targetusername SCRATCH --permset Integration
