.PHONY: render core-metrics emperor-plot beta-group-sig volatility test

clean:
	rm -r **/out/*

render:
	q2cwl template conda tools/

core-metrics: render
	cwl-runner --outdir core-metrics/out tools/qiime2.plugins.diversity.pipelines.core_metrics_phylogenetic.cwl core-metrics/job.yaml

emperor-plot: render
	cwl-runner --outdir emperor-plot/out tools/qiime2.plugins.emperor.visualizers.plot.cwl emperor-plot/job.yaml

beta-group-sig: render
	cwl-runner --outdir beta-group-sig/out tools/qiime2.plugins.diversity.visualizers.beta_group_significance.cwl beta-group-sig/job.yaml

table-summary: render
	cwl-runner --outdir table-summary/out tools/qiime2.plugins.feature_table.visualizers.summarize.cwl table-summary/job.yaml

volatility: render
	cwl-runner --outdir volatility/out tools/qiime2.plugins.longitudinal.visualizers.volatility.cwl volatility/job.yaml

exporting-file: render
	cwl-runner --outdir exporting-file/out tools/qiime2.tools.export.cwl exporting-file/job.yaml

exporting-dir: render
	cwl-runner --outdir exporting-dir/out tools/qiime2.tools.export.cwl exporting-dir/job.yaml

importing-file: exporting-file
	cwl-runner --outdir importing-file/out tools/qiime2.tools.import.cwl importing-file/job.yaml

importing-dir: exporting-dir
	cwl-runner --outdir importing-dir/out tools/qiime2.tools.import.cwl importing-dir/job.yaml

test: core-metrics emperor-plot beta-group-sig table-summary volatility importing-file importing-dir
	:
