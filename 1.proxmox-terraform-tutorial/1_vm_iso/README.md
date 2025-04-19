# Proxmox Terraform Tutorial - Multi-Node VM Creation

A minimal tutorial for creating VMs on multiple Proxmox nodes using Terraform.

## Prerequisites

- Proxmox VE 7.x or later
- Terraform 1.1.0 or later
- Two Proxmox nodes in a cluster

## Step 1: Create API Tokens

1. Log in to each Proxmox node web interface as `root@pam`
2. Go to Datacenter → Permissions → API Tokens
3. Click "Add" and create a token:
   - User: `root@pam`
   - Token ID: Choose any name (e.g., `my-token`, `automation`, `pve-token`)
   - Privilege Separation: Enable
4. **SAVE THE TOKEN SECRET** - you won't see it again!

## Step 2: Configure Environment

1. Copy `.env.example` to `.env`:
   ```bash
   cp .env.example .env
   ```

2. Edit `.env` with your actual values:
   ```bash
   # Proxmox Connection Settings
   PROXMOX_USER="root@pam"
   PROXMOX_TOKEN_NAME="your-token-id"     # Use the Token ID you created above
   PROXMOX_TOKEN_SECRET="your-actual-token-secret"

   # Node 1 Settings
   PROXMOX_NODE1_HOST="192.168.219.121"  # Your first node IP
   PROXMOX_NODE1_PORT="8006"
   PROXMOX_NODE1_NAME="pve1"             # Your first node name

   # Node 2 Settings
   PROXMOX_NODE2_HOST="192.168.219.122"  # Your second node IP
   PROXMOX_NODE2_PORT="8006"
   PROXMOX_NODE2_NAME="pve2"             # Your second node name

   # VM Settings for Node 1
   VM1_NAME="pve-node-01"
   VM1_ID="104"                          # Unique ID
   VM1_IP="192.168.220.104/24"          # Your desired IP
   VM1_GATEWAY="192.168.219.1"          # Your gateway
   VM1_MAC="BC:24:11:00:08:11"          # Unique MAC
   VM1_MEMORY="2048"
   VM1_CORES="2"
   VM1_STORAGE="local-lvm"
   VM1_ISO="ubuntu-22.04.5-live-server-amd64.iso"

   # VM Settings for Node 2
   VM2_NAME="pve-node-02"
   VM2_ID="105"                          # Different from VM1_ID
   VM2_IP="192.168.220.105/24"          # Different from VM1_IP
   VM2_GATEWAY="192.168.219.1"
   VM2_MAC="BC:24:11:00:08:12"          # Different from VM1_MAC
   VM2_MEMORY="2048"
   VM2_CORES="2"
   VM2_STORAGE="local-lvm"
   VM2_ISO="ubuntu-22.04.5-live-server-amd64.iso"
   ```

## Step 3: Prepare ISO

1. Download Ubuntu ISO:
   ```bash
   wget https://releases.ubuntu.com/22.04/ubuntu-22.04.5-live-server-amd64.iso
   ```

2. Upload to both Proxmox nodes:
   - Go to local storage → ISO Images
   - Click "Upload" and select the ISO

## Step 4: Create VMs

```bash
./terraform_start.sh
```

## Step 5: Clean Up

```bash
./terraform_remove.sh
```

## Troubleshooting

- **Token Issues**: Verify token secret in `.env` and ensure `PROXMOX_TOKEN_NAME` matches your Token ID
- **ISO Issues**: Check ISO exists on both nodes
- **Network Issues**: Verify vmbr0 exists, IPs don't conflict
- **Storage Issues**: Check storage exists on both nodes 