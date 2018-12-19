
using Documenter
using DocumenterMarkdown
using UncertainData
using Distributions
using KernelDensity

PAGES = [
    "index.md",
    "Uncertain values" => [
        "uncertain_values/uncertainvalues_examples.md",
        "uncertain_values/uncertainvalues_overview.md",
        "uncertain_values/uncertainvalues_kde.md",
        "uncertain_values/uncertainvalues_fitted.md",
        "uncertain_values/uncertainvalues_theoreticaldistributions.md"
    ],
	"Uncertain datasets" => [
		"uncertain_datasets/uncertain_datasets_overview.md"
	],
    "Uncertain statistics" => [
        "Core statistics" => [
            "uncertain_statistics/core_stats/core_statistics.md"
        ],

        "Hypothesis tests" => [
			"uncertain_statistics/hypothesistests/hypothesis_tests_overview.md",
            "uncertain_statistics/hypothesistests/one_sample_t_test.md",
            "uncertain_statistics/hypothesistests/equal_variance_t_test.md",
            "uncertain_statistics/hypothesistests/unequal_variance_t_test.md",
            "uncertain_statistics/hypothesistests/exact_kolmogorov_smirnov_test.md",
            "uncertain_statistics/hypothesistests/approximate_twosample_kolmogorov_smirnov_test.md",
            "uncertain_statistics/hypothesistests/jarque_bera_test.md",
            "uncertain_statistics/hypothesistests/mann_whitney_u_test.md",
            "uncertain_statistics/hypothesistests/anderson_darling_test.md"
        ],
    ],
    "Sampling constraints" => [
        "sampling_constraints/available_constraints.md",
        "sampling_constraints/constrain_uncertain_values.md"
    ],
    "Resampling" => [
		"resampling/resampling_uncertain_values.md"
	],
    "implementing_algorithms_for_uncertaindata.md"
]

makedocs(
    modules = [UncertainData],
    sitename = "UncertainData.jl documentation",
    format = Markdown(),
    pages = PAGES
)

if !Sys.iswindows()
    deploydocs(
        deps   = Deps.pip("mkdocs==0.17.5", "mkdocs-material==2.9.4",
        "python-markdown-math", "pygments", "pymdown-extensions"),
        repo   = "github.com/kahaaga/UncertainData.jl.git",
        target = "site",
        make = () -> run(`mkdocs build`)
    )
end
