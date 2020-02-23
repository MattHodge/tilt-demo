K8S_NAMESPACE = "devenv-matt"

allow_k8s_contexts('kind-kind')

def create_namespace(namespace):
    k8s_yaml(helm("tilt/k8s/namespace", namespace=namespace))

def intake(namespace, live_update=False):
    k8s_yaml(helm("apps/intake/k8s", namespace=namespace, name="intake"))

    k8s_resource("intake", port_forwards=["9999"])

    custom_build(
      'localhost:5000/intake',
      'cd apps/intake && docker build -t $EXPECTED_REF .',
      deps=[
          './apps/intake/Dockerfile',
          './apps/intake/bin/intake'
      ],
      live_update=[
          sync('./apps/intake/bin', '/bin'),
          run('restart.sh'),
      ],
    )

    if live_update:
        local_resource(
            name="intake-liveupdate",
            cmd="./tilt/go_build_temp_location.sh intake",
            deps=[
                "./apps/intake/",
            ],
            ignore=[
                "**",
                "!**/*.go"
            ],
            auto_init=False,
            trigger_mode=TRIGGER_MODE_MANUAL
        )

def intake_db_workflows(namespace):
    k8s_yaml(helm("apps/intake-db-workflows/k8s", namespace=namespace))

    docker_build(
        "localhost:5000/intake-db-workflows",
        "apps/intake-db-workflows",
        dockerfile="apps/intake-db-workflows/Dockerfile",
    )

    k8s_resource("intake-db-drop", trigger_mode=TRIGGER_MODE_MANUAL)
    k8s_resource("intake-db-migrate", trigger_mode=TRIGGER_MODE_MANUAL, resource_deps=['intake-db-drop'])

def emitter(namespace):
    k8s_yaml(helm("apps/emitter/k8s", namespace=namespace, name="emitter"))

    docker_build(
        "localhost:5000/emitter",
        "apps/emitter",
        live_update=[
            sync('./apps/emitter/main.py', '/app/main.py'),
            run('restart.sh'),
        ],
    )

def mysql(namespace):
    k8s_yaml(helm("tilt/k8s/mysql", namespace=namespace, name="mysql"))
    k8s_resource("mysql", port_forwards=["3306"])

create_namespace(K8S_NAMESPACE)
#intake(K8S_NAMESPACE, live_update=False)
#emitter(K8S_NAMESPACE)
#mysql(K8S_NAMESPACE)
#intake_db_workflows(K8S_NAMESPACE)
