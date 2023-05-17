SOURCE_IMAGE = os.getenv("SOURCE_IMAGE", default='harbor.lab.tw/tanzu-java-web-app-live-source')
LOCAL_PATH = os.getenv("LOCAL_PATH", default='.')
NAMESPACE = os.getenv("NAMESPACE", default='tap-dev')
OUTPUT_TO_NULL_COMMAND = os.getenv("OUTPUT_TO_NULL_COMMAND", default=' > /dev/null ')

k8s_custom_deploy(
    'tanzu-java-web-app-live',
    apply_cmd="tanzu apps workload apply -f config/workload.yaml --debug --live-update" +
               " --local-path " + LOCAL_PATH +
               " --source-image " + SOURCE_IMAGE +
               " --namespace " + NAMESPACE +
               " --yes " +
               OUTPUT_TO_NULL_COMMAND +
               " && kubectl get workload tanzu-java-web-app-live --namespace " + NAMESPACE + " -o yaml",
    delete_cmd="tanzu apps workload delete -f config/workload.yaml --namespace " + NAMESPACE + " --yes",
    deps=['pom.xml', './target/classes'],
    container_selector='workload',
    live_update=[
      sync('./target/classes', '/workspace/BOOT-INF/classes')
    ]
)

k8s_resource('tanzu-java-web-app-live', port_forwards=["8080:8080"],
            extra_pod_selectors=[{'serving.knative.dev/service': 'tanzu-java-web-app-live'}])

allow_k8s_contexts('kubernetes-admin@tim-k8s')
