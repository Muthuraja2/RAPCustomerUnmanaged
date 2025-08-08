# RAP Customer Unmanaged

A comprehensive implementation of SAP RAP (ABAP RESTful Application Programming Model) using an unmanaged scenario for Customer management operations.

## Overview

This project demonstrates the implementation of an unmanaged RAP Business Object for Customer entities, featuring bulk customer creation capabilities through OData V4 actions.

## Architecture

### Business Object Structure
- **Entity**: Customer
- **Implementation Type**: Unmanaged
- **Service Binding**: OData V4
- **Action**: `bulkCreateCustomer` - Creates multiple customer records

### Data Model
The Customer entity includes the following fields:
- `NAME` - Customer name (max 30 characters)
- `CITY` - Customer city (max 20 characters) 
- `COUNTRY` - Country code (3 characters)
- `EMAIL` - Email address (max 40 characters)

## API Testing

### Endpoint Configuration

**Base URI Pattern:**
```
/sap/opu/odata4/sap/{service_id}/srvd_a2x/sap/{service_definition}/0001/Customer/SAP__self.bulkCreateCustomer
```

**Example URI:**
```
/sap/opu/odata4/sap/zmuthu_sb_customer/srvd_a2x/sap/zmuthu_sd_customer/0001/Customer/SAP__self.bulkCreateCustomer
```

### HTTP Request Details

| Property | Value |
|----------|--------|
| **Method** | `POST` |
| **Content-Type** | `application/json` |
| **Accept** | `application/json` |

### Request Body Structure

The action accepts a JSON payload with a `DATA` array containing customer objects:

```json
{
    "DATA": [
        {
            "NAME": "Praveen1",
            "CITY": "Theni", 
            "COUNTRY": "IN",
            "EMAIL": "muthu@gmail.com"
        },
        {
            "NAME": "Kumar1",
            "CITY": "Theni",
            "COUNTRY": "IN", 
            "EMAIL": "muthu@gmail.com"
        },
        {
            "NAME": "Radha1",
            "CITY": "Theni",
            "COUNTRY": "IN",
            "EMAIL": "muthu@gmail.com"
        }
    ]
}
```


<img width="2400" height="1102" alt="image" src="https://github.com/user-attachments/assets/3efbb81c-d099-4903-983e-6c709e553ff0" />

