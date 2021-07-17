# nomad-gcp

```shell-session
$ terraform init
$ terraform apply
```

Quando perguntado, preencha o ID do seu projeto na GCP e confirme.

## Conectando nas instâncias via SSH com gcloud

Para conectar nas VMs usando a CLI `gcloud` use o comando:

```shell-session
$ gcloud compute ssh --project=PROJECT_ID --zone=us-central1-a nomad-[server|client]-X
```

Onde `PROJECT_ID` é o ID do seu projeto e o último parâmetro é o nome da VM
(`nomad-server-1`, `nomad-client-2` etc.).

Documentação: https://cloud.google.com/compute/docs/instances/connecting-to-instance#connecting_to_vms

## Fazendo o port-forwarding das VMs para a sua máquina local

Para conectar na API do Nomad remota, é preciso primeiro criar um
port-forwarding via SSH:

```shell-session
$ gcloud compute ssh nomad-server-1 \
    --project PROJECT_ID \
    --zone us-central1-a \
    -- -NL 4646:localhost:4646
```

Depois disso, a API do Nomad no servidor remoto estará acessível no endereço
padrão `localhost:4646`.

Documentação: https://cloud.google.com/solutions/connecting-securely#port-forwarding-over-ssh

## Copiando arquivos locais para uma VM

```shell-session
$ gcloud compute scp \
    --project PROJECT_ID \
    --zone us-central1-a \
    ./path/to/file nomad-[server|client]-X:~/
```

Documentação: https://cloud.google.com/sdk/gcloud/reference/compute/scp
