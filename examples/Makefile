.PHONY: render core-metrics emperor-plot beta-group-sig volatility test

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

test: core-metrics emperor-plot beta-group-sig table-summary volatility
	:
