# Pre-workshop verification checklist

Stuff that's drafted but not proven. Cross-check before running this with
real students.

## Terraform checkpoints — every stage must `init` + `plan` + `apply` cleanly

- [ ] `stage-1-starter/` — `terraform init` succeeds with real AWS creds
- [ ] `stage-2-keys-and-sg/` — `apply` creates the key pair + SG, `destroy` cleans them up
- [ ] `stage-3-ec2/` — `apply` brings up an EC2 in eu-west-1, outputs print, SSH works
- [ ] `stage-4-minecraft/` — full Minecraft + Dynmap reachable on the public IP

## URLs and artifacts to pin

- [ ] PaperMC download URL (currently in stage-4 defaults — verify it still resolves)
- [ ] Dynmap plugin URL (Curseforge CDN URL — these rot fast; consider mirroring)
- [ ] Confirm `openjdk-21-jre-headless` is in jammy's apt repos (or pick another Java)
- [ ] Confirm `t3.small` is the right instance type — measure actual MC + Dynmap memory use

## AWS prep

- [ ] Raise EC2 vCPU quota in eu-west-1 to ≥ 45 (20 students × t3.small = 40 vCPUs)
- [ ] Confirm default VPC exists in eu-west-1 (`aws ec2 describe-vpcs`)
- [ ] Run `iam-gen` and produce real student credentials on a pen drive
- [ ] Tag-based teardown script (we still rely on each student running `destroy`)

## Verification scripts to write

- [ ] `scripts/verify-stage.sh <stage>` — `init`, `plan`, `apply`, smoke-test, `destroy`
- [ ] `scripts/smoke-mc.sh <ip>` — TCP probe on 25565, HTTP probe on 8123
- [ ] CI: run all stages in a sandbox AWS account on PR

## Open content questions

- [ ] White-on-yellow titles — confirm the CSS override actually fixes it
- [ ] Demo domain for the live DNS section — pick one, set TTL to 60 in advance
- [ ] "What we did in section 4" — section 4 is a console demo; check no other slide
      implies students typed commands there
