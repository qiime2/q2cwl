# q2cwl
Interface for automatically generating CWL tools from QIIME 2 actions

## How it works

QIIME 2's SDK provides information about all registered plugins and actions.
Using this information, q2cwl is able to template out CWL tools definitions
for use in CWL workflows.

There are currently two ways to template a tool definition, via conda or docker.

## Conda Templates

1. Create a conda environment that contains the QIIME 2 plugins which you would
   like to template into CWL tools. This environment must include q2cwl in order
   to work:

   ```bash
   pip install cwlref-runner
   pip install .
   ```

2. Identify a directory where the tools should be installed (`output-dir/` in this example).

3. Run the following command within your conda environment:
   ```bash
   q2cwl template conda output-dir/
   ```

   (You can also run `q2cwl template conda --plugin <plugin name> output-dir/` to template only a single plugin)

4. Test your install with cwl-runner

## Docker Templates

1. Create a Dockerfile that inherits from `qiime2/q2cwl-core`. This base image will
   provide miniconda, the QIIME 2 framework, and q2cwl. This step and step 2 can be skipped if an image already exists.

2. Build (and optionally upload) that docker image for use.

3. Identify a directory where the tools should be installed (`output-dir/` in this example).

4. Run one of the following commands:
   If you have a docker image uploaded to docker-hub:
   ```
   docker run -t <YOUR DOCKER IMAGE> -v $PWD/output-dir/:/tmp/cwl-tools/ q2cwl template docker <YOUR DOCKER IMAGE>
   ```
   Otherwise:
   ```
   docker run -t <YOUR DOCKER IMAGE> -v $PWD/output-dir/:/tmp/cwl-tools/ q2cwl template docker --local <YOUR DOCKER IMAGE>
   ```

   (`<YOUR DOCKER IMAGE>` must be provided twice, once for docker run, and once again at the end
    so that q2cwl knows to template the image ID into the CWL tool.)

5. Test your install with cwl-runner

(You may use `qiime2/q2cwl-core` if you do not have a Dockerfile you would like to use, and do not want to install any
 extra plugins.)

## Examples

Examples are available in `examples/`. There is a Makefile which will use `cwl-runner`.

This assumes you have a conda environment with QIIME 2 activated and have run:
```bash
pip install .
```
to install q2cwl.

Run the following to test all examples:
```bash
cd examples/
make test
```
