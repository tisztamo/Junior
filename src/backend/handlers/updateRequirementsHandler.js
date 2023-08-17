import yaml from 'js-yaml';
import { loadPromptDescriptor } from "../../prompt/loadPromptDescriptor.js";
import { savePromptDescriptor } from "../../prompt/savePromptDescriptor.js";

export const updateRequirementsHandler = async (req, res) => {
  const requirements = req.body.requirements;
  
  try {
    const fileContent = await loadPromptDescriptor();
    const document = yaml.load(fileContent);
    document.requirements = requirements;
    
    const newYamlStr = yaml.dump(document);
    await savePromptDescriptor(newYamlStr);
    
    res.status(200).json({ message: "Requirements updated successfully" });
  } catch (error) {
    console.log(error);
    res.status(500).json({ message: "Internal server error" });
  }
};
