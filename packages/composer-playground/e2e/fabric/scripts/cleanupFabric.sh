#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Grab the parent (root) directory.
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"

KUBERNETES_FILE=${DIR}/hlfv1/kubernetes.yaml

ARCH=$ARCH kubectl delete -f ${KUBERNETES_FILE}
ARCH=$ARCH kubectl -f ${KUBERNETES_FILE} delete pods --all

pkill verdaccio || true

rm -rf ${HOME}/.composer/cards/Test*
rm -rf ${HOME}/.composer/client-data/Test*
rm -rf ${HOME}/.composer/cards/admin*
rm -rf ${HOME}/.composer/client-data/admin*
rm -rf ${DIR}/../downloads
rm -rf ${DIR}/scripts/storage