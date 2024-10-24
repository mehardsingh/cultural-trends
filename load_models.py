from transformers import AutoModelForCausalLM, AutoModelForSeq2SeqLM, AutoTokenizer
import os
import argparse

def load_and_save_models(model_name, save_name, save_dir):
    print(f"load_and_save_models > {model_name}")
    print(f"making saving directory")
    local_dir = os.path.join(save_dir, save_name)  # Specify your desired local directory
    os.makedirs(local_dir, exist_ok=True)
    
    # Load the model and tokenizer from the Hugging Face Hub
    print(f"loading model")
    if "mt0" in model_name:
        model = AutoModelForSeq2SeqLM.from_pretrained(model_name)
    else:    
        model = AutoModelForCausalLM.from_pretrained(model_name)

    print(f"loading tokenizer")
    tokenizer = AutoTokenizer.from_pretrained(model_name)

    # Save the model and tokenizer locally
    print(f"saving model")
    model.save_pretrained(local_dir)
    print(f"saving tokenizer")
    tokenizer.save_pretrained(local_dir)

if __name__ == "__main__":
    # Set up argument parsing
    parser = argparse.ArgumentParser(description="Download and save a Hugging Face model.")
    parser.add_argument(
        "--model_name", 
        type=str, 
        required=True, 
        help="The name of the model to download from Hugging Face Hub (e.g., 'meta-llama/Llama-2-13b-chat-hf')."
    )
    parser.add_argument(
        "--save_name", 
        type=str, 
        required=True, 
        help="The name to use when saving the model locally."
    )
    parser.add_argument(
        "--save_dir", 
        type=str, 
        required=True, 
        help="The directory where the model will be saved."
    )

    args = parser.parse_args()
    print(args.model_name, args.save_name, args.save_dir)
    load_and_save_models(args.model_name, args.save_name, args.save_dir)