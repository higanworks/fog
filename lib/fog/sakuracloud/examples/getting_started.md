# Getting started for SakuraCloud

## Links

- Product Information: http://cloud.sakura.ad.jp/
- API Reference(1.1): http://developer.sakura.ad.jp/cloud/api/1.1/

## Requeirement

- API TOKEN
- API TOKEN SECRET

You can retreave them from dashboard.


## Resources

|Service |Class |Description |
|----|----|----|
|Volume(disk) |Fog::Volume::SakuraCloud |Block device for server. |
|Compute |Fog::Compute::SakuraCloud |Server. |

## Simple start

Inital boot from template with ssh key.

```
require 'fog'
compute = Fog::Compute::SakuraCloud.new(
  :sakuracloud_api_token => 'YOUR_API_TOKEN',
  :sakuracloud_api_token_secret => 'YOUR_API_TOKEN_SECRET'
)


server = compute.servers.create_with({
  :sakuracloud_api_token => 'YOUR_API_TOKEN',
  :sakuracloud_api_token_secret => 'YOUR_API_TOKEN_SECRET',
  :diskplan => 4,                   # Type SSD
  :sourcearchive => '112500463685', # Ubuntu12.04
  :sshkey => '11260003****',        # Your SSH Key ID
  :serverplan => '2001'            # Server Type
})
```

You can login or integrate with configuration management tools to server at once.


## Services

Usage for SakuraCloud Services.

### Volume(disk) Service

Initailize Volume service.

```
require 'fog'
volume = Fog::Volume::SakuraCloud.new(
  :sakuracloud_api_token => 'YOUR_API_TOKEN',
  :sakuracloud_api_token_secret => 'YOUR_API_TOKEN_SECRET'
)
```


#### Listing disk plans

use `volume.plans`.

```
> volume.plans

=> [  <Fog::Volume::SakuraCloud::Plan
    ID=4,
    Name="SSDプラン"
  >,
   <Fog::Volume::SakuraCloud::Plan
    ID=2,
    Name="標準プラン"
  >]
```



#### Listing volume templates(archives)

use `volume.archives`.

```
require 'fog'
volume = Fog::Volume::SakuraCloud.new(
  :sakuracloud_api_token => 'YOUR_API_TOKEN',
  :sakuracloud_api_token_secret => 'YOUR_API_TOKEN_SECRET'
)


> volume.archives

=> [  <Fog::Volume::SakuraCloud::Archive
    ID="112500514887",
    Name="CentOS 5.10 64bit (基本セット)"
  >,
   <Fog::Volume::SakuraCloud::Archive
    ID="112500571575",
    Name="CentOS 6.5 64bit (基本セット)"
  >,
   <Fog::Volume::SakuraCloud::Archive
    ID="112500556904",
    Name="Scientific Linux 6.4 64bit (基本セット)"
  >,
   <Fog::Volume::SakuraCloud::Archive
    ID="112500587018",
    Name="Scientific Linux 6.5 RC1 64bit (基本セット)"
  >,
   <Fog::Volume::SakuraCloud::Archive
    ID="112500556903",
    Name="FreeBSD 8.3 64bit (基本セット)"
  >,
   <Fog::Volume::SakuraCloud::Archive
    ID="112500556906",
    Name="FreeBSD 9.1 64bit (基本セット)"
  >,
   <Fog::Volume::SakuraCloud::Archive
    ID="112500556907",
    Name="Ubuntu Server 13.04 64bit (基本セット)"
  >,
   <Fog::Volume::SakuraCloud::Archive
    ID="112500463685",
    Name="Ubuntu Server 12.04.3 LTS 64bit (基本セット)"
  >,
   <Fog::Volume::SakuraCloud::Archive
    ID="112500490219",
    Name="Ubuntu Server 13.10 64bit(基本セット)"
  >,
   <Fog::Volume::SakuraCloud::Archive
    ID="112500556909",
    Name="Debian GNU/Linux 6.0.7 64bit (基本セット)"
  >,
-- snip --
```

#### Create volume from templates(archives)

use `volume.disks.create` with `:Name`, `:Plan`(Plan ID) and `:SourceArchive`(ID, optional)

##### Example: Create SSD installed 'Ubuntu 12.04'.

```
disk = volume.disks.create :Name => 'foobar',
                           :Plan  => 4,  # Type SSD
                           :SourceArchive => 112500463685 # Ubuntu12.04
```

It creates disk.

```
=>   <Fog::Volume::SakuraCloud::Disk
    ID="112600053876",
    Name="foobar",
    Connection="virtio",
    Availability="migrating",
    Plan={"ID"=>4, "StorageClass"=>"iscsi1204", "Name"=>"SSDプラン"},
    SizeMB=20480,
    SourceDisk=nil,
    SourceArchive={"ID"=>"112500463685", "Name"=>"Ubuntu Server 12.04.3 LTS 64bit (基本セット)", "Availability"=>"available", "SizeMB"=>20480, "Plan"=>{"ID"=>2, "StorageClass"=>"iscsi1204", "Name"=>"標準プラン"}, "Storage"=>{"ID"=>"3100297001", "Class"=>"iscsi1204", "Name"=>"sac-is1b-arc-st01", "Zone"=>{"ID"=>31002, "Name"=>"is1b", "Region"=>{"ID"=>310, "Name"=>"石狩"}}, "DiskPlan"=>{"ID"=>2, "StorageClass"=>"iscsi1204", "Name"=>"標準プラン"}}, "BundleInfo"=>nil}
  >
```

#### Listing available disks

use `volume.disks`

```
> volume.disks

=> [  <Fog::Volume::SakuraCloud::Disk
    ID="112600053837",
    Name="ed86efca-d7f1-4367-97df-30e16c4f331e",
    Connection="virtio",
    Availability="available",
    Plan={"ID"=>4, "StorageClass"=>"iscsi1204", "Name"=>"SSDプラン"},
    SizeMB=20480,
    SourceDisk=nil,
    SourceArchive={"ID"=>"112500463685", "Name"=>"Ubuntu Server 12.04.3 LTS 64bit (基本セット)", "Availability"=>"available", "SizeMB"=>20480, "Plan"=>{"ID"=>2, "StorageClass"=>"iscsi1204", "Na
  >,
   <Fog::Volume::SakuraCloud::Disk
    ID="112600053840",
    Name="2a3f571a-2562-49e1-a4ea-86f7cf34c571",
    Connection="virtio",
    Availability="available",
    Plan={"ID"=>4, "StorageClass"=>"iscsi1204", "Name"=>"SSDプラン"},
    SizeMB=20480,
    SourceDisk=nil,
    SourceArchive={"ID"=>"112500463685", "Name"=>"Ubuntu Server 12.04.3 LTS 64bit (基本セット)", "Availability"=>"available", "SizeMB"=>20480, "Plan"=>{"ID"=>2, "StorageClass"=>"iscsi1204", "Na
  >,
-- snip --

```

Get Disk ID or any attributes.

```
> volume.disks.first.ID
=> "112600053837"

> volume.disks.first.SizeMB
=> 20480
```

or

```
> disk = volume.disks.first
> disk.ID
=> "112600053837"
```

You can reload disk attributes.

```
> disk.reload
=>   <Fog::Volume::SakuraCloud::Disk
    ID="112600053837",
    Name="ed86efca-d7f1-4367-97df-30e16c4f331e",
    Connection="virtio",
    Availability="available",
    Plan={"ID"=>4, "StorageClass"=>"iscsi1204", "Name"=>"SSDプラン"},
    SizeMB=20480,
    SourceDisk=nil,
    SourceArchive={"ID"=>"112500463685", "Name"=>"Ubuntu Server 12.04.3 LTS 64bit (基本セット)", "Availability"=>"available", "SizeMB"=>20480, "Plan"=>{"ID"=>2, "StorageClass"=>"iscsi1204", "Name"=>"標準プラン"}, "Storage"=>{"ID"=>"3100297001", "Class"=>"iscsi1204", "Name"=>"sac-is1b-arc-st01", "Zone"=>{"ID"=>31002, "Name"=>"is1b", "Region"=>{"ID"=>310, "Name"=>"石狩"}}, "DiskPlan"=>{"ID"=>2, "StorageClass"=>"iscsi1204", "Name"=>"標準プラン"}}, "BundleInfo"=>nil}
  >
```

#### Delete disk

use `volume.disks.delete('Disk_ID')`

```
> volume.disks.delete('112600053837')

=> true
```

or execute delete method for disk.

```
> volume.disks.first.delete

=> true
```

##### Example: Delete all disks

```
> volume.disks.each {|d| d.delete}
```


### SSH Key Service (Part of the Compute Service)

Initailize Compute service.

```
require 'fog'
compute = Fog::Compute::SakuraCloud.new(
  :sakuracloud_api_token => 'YOUR_API_TOKEN',
  :sakuracloud_api_token_secret => 'YOUR_API_TOKEN_SECRET'
)
```

#### Listing SSH Keys

use `compute.ssh_keys`

```
> compute.ssh_keys

=> [  <Fog::Compute::SakuraCloud::SshKey
    ID="11260003****",
    Name="sawanobori",
    PublicKey="ssh-rsa ***********************"
  >]
```


#### Add SSH Key to disk.

Work with Volume service.

use `configure` method with SSH Key ID.

##### Example

```
> volume.disks.first.configure(11260003****)

=> true
```


### Compute Service


TODO: Write...

