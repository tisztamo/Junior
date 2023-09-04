import { createSignal, onCleanup } from 'solid-js';
import fetchRepoInfo from '../service/fetchers/fetchRepoInfo';

const RepoInfo = () => {
    const [repoInfo, setRepoInfo] = createSignal({});
    const [expanded, setExpanded] = createSignal(false);

    // Fetch the repo info on component mount and set it to state
    const fetchAndSetRepoInfo = async () => {
        const data = await fetchRepoInfo();
        setRepoInfo(data);
    }

    fetchAndSetRepoInfo();

    const toggleExpand = () => {
        setExpanded(!expanded());
    }

    return (
        <span 
            class="text-sm font-mono bg-gray-200 dark:bg-gray-700 px-1 py-0.5 mt-2 rounded cursor-pointer" 
            onClick={toggleExpand}
        >
            {expanded() ? (
                <>
                    <div>Working Dir: {repoInfo().workingDir}</div>
                    <div>URL: {repoInfo().url}</div>
                    <div>Branch: {repoInfo().branch}</div>
                    <div>Name: {repoInfo().name}</div>
                    <div>Description: {repoInfo().description}</div>
                </>
            ) : (
                <>
                    {repoInfo().name} {repoInfo().branch}
                </>
            )}
        </span>
    );
};

export default RepoInfo;
