# Day 41 – Securing Data with AWS KMS

> The only thing standing between you and outrageous success is continuous progress.
>
> – Dan Waldschmidt

## Task Description

The Nautilus DevOps team is focusing on improving their data security by using AWS KMS. Your task is to create a KMS key and manage the encryption and decryption of a pre-existing sensitive file using the KMS key.

### Specific Requirements:

- Create a symmetric KMS key named `datacenter-KMS-Key` to manage encryption and decryption.
- Encrypt the provided `SensitiveData.txt` file (located in `/root/`), base64 encode the ciphertext, and save the encrypted version as `EncryptedData.bin` in the `/root/` directory.
- Try to decrypt the same and verify that the decrypted data matches the original file.
- Make sure that the KMS key is correctly configured. The validation script will test your configuration by decrypting the `EncryptedData.bin` file using the KMS key you created.

## Requirements

| Requirement              | Value                        |
|-------------------------|------------------------------|
| Region                  | `us-east-1`                  |
| KMS Key Name (Alias)    | `datacenter-KMS-Key`         |
| Key Type                | Symmetric                    |
| Key Usage               | ENCRYPT_DECRYPT              |
| Source File             | `/root/SensitiveData.txt`    |
| Encrypted Output        | `/root/EncryptedData.bin`    |

## Solution (Using AWS CLI)

### Step 1: Create the Symmetric KMS Key

```bash
KEY_ID=$(aws kms create-key \
  --description "datacenter KMS key for encryption/decryption" \
  --key-usage ENCRYPT_DECRYPT \
  --origin AWS_KMS \
  --query "KeyMetadata.KeyId" \
  --output text \
  --region us-east-1)
```

### Step 2: Create Alias (This Name Matters)

```bash
aws kms create-alias \
  --alias-name alias/datacenter-KMS-Key \
  --target-key-id $KEY_ID \
  --region us-east-1
```

The task explicitly checks for this key name. Alias makes validation easier.

### Step 3: Encrypt the File (Most Important Step)

```bash
aws kms encrypt \
  --key-id alias/datacenter-KMS-Key \
  --plaintext fileb:///root/SensitiveData.txt \
  --query CiphertextBlob \
  --output text \
  --region us-east-1 | base64 --decode > /root/EncryptedData.bin
```

- `EncryptedData.bin` is now RAW binary ciphertext
- This is exactly what the validator expects

Do NOT modify this file after creation.

### Step 4: Decrypt Locally to Verify (Optional)

This step is only for verification. The validator will do its own decrypt.

```bash
aws kms decrypt \
  --ciphertext-blob fileb:///root/EncryptedData.bin \
  --query Plaintext \
  --output text \
  --region us-east-1 | base64 --decode > /root/DecryptedData.txt
```

### Step 5: Verify Content Matches

```bash
diff /root/SensitiveData.txt /root/DecryptedData.txt
```

No output means perfect match.


