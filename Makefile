.SILENT: deploy announcement
.PHONY:	deploy deploy_frontend deploy_backend announcement

PREFIX = sam0392in
IMAGE = sam
PTAG = sam_prod_1.1
STAG = sam_staging_1.1

deploy:
	docker build -t ${PREFIX}/${IMAGE}:${PTAG} . -f Dockerfile-prod && \
    docker push ${PREFIX}/${IMAGE}:${PTAG} && \
	docker build -t ${PREFIX}/${IMAGE}:${STAG} . -f Dockerfile-staging && \
    docker push ${PREFIX}/${IMAGE}:${STAG} && \
    helm upgrade -i sam-prod-server -n k8s-workshop ./chart/prod \
    --set-string image.tag=${PTAG} && \
    helm upgrade -i sam-staging-server -n k8s-workshop ./chart/staging \
             --set-string image.tag=${STAG}


build_prod:
	docker build -t ${PREFIX}/${IMAGE}:${PTAG} . -f Dockerfile-prod && \
		docker push ${PREFIX}/${IMAGE}:${PTAG}

deploy_prod:
	helm upgrade -t sam-prod-server -n devops-services ./chart/prod \
        --set-string image.tag=${PTAG}

build_staging:
	docker build -t ${PREFIX}/${IMAGE}:${STAG} . -f Dockerfile-staging && \
		docker push ${PREFIX}/${IMAGE}:${STAG}

deploy_staging:
	helm upgrade -t sam-prod-server -n devops-services ./chart/staging \
        --set-string image.tag=${STAG}