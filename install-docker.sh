# dnf update -y
dnf install -y dnf-utils device-mapper-persistent-data lvm2

dnf config-manager --add-repo=https://download.docker.com/linux/oracle/docker-ce.repo
if [ $? -ne 0 ]; then
	echo "WARNING: dnf add repo fail" >&2
	if [ ! -f /etc/yum.repos.d/docker-ce.repo ]; then
		echo "add by docker-ce.repo manual ..." >&2
		echo "H4sIAKfEbGcAA+2VQU+DMBiGOfMretiVFQa6xGQn59XLvBkPrHzCMtYubVH372WwuegCmkg1mvc5
0OZr6ccDb0KmxJp0IGisaas8J4Q1l0nSjDUfx/hiOvWiZBrHUTKZxJEXRvU19ljo5nHeUxmbasY8
rZTt2/fZ+h/lPjsGIKhfxLKkB1+mG5rNmzK7vmGLpswCNlqmhlItCn8/qXQ5K6zdmivOM/UsS5Vm
4/awsVAbXq5k9cIFSasMH2kqqb7piTR/O4a3DX2S+yGbRX6+zUVBYt1O17T7eod6v++fyQQZLat8
JR9Vt9b8uGUowaZn0KkZOtA0qtKi59MtmnXzPa+2iVMdS8aeWdzVRRfx2zdzp9ETvYOQ8+A5FuwI
3cFuyMi5E5GrvLDl7kzitq27iN2hpVOfnvCdzJzn70dMO1J40hwyiIMb/fbvHwAAAAAAAAAAAAAA
AAAAAAAAwD/hFTqzLqgAKAAA" |base64 -d |tar xzf -
        	cp -f docker-ce.repo /etc/yum.repos.d/
	else
		echo "repo file exits, continue" >&2
	fi
fi
dnf install -y docker-ce docker-ce-cli containerd.io
docker --version
